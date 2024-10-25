export class calculate{


  tokenize(expression: string): string[] {
    // 正则表达式匹配数字（包括整数、小数、负数）和操作符（+、-、*、/、括号）
    const regex = /(\d+\.\d+|\d+|\.\d+|[-+*/()]|\d+\.)/g;
    return expression.match(regex) || [];
  }
  precedence (op: string): number {
    if (op === '+' || op === '-') {
      return 1;
    }
    if (op === '*' || op === '/') {
      return 2;
    }
    return 0;
  }
  applyOpFromStacks(numStack: number[], opStack: string[]): void {
    const op = opStack.pop()!;
    const val2 = numStack.pop()!;
    const val1 = numStack.pop()!;
    numStack.push(this.applyOp(val1, val2, op));
  }
  applyOp(a: number, b: number, op: string): number {
    switch (op) {
      case '+': return a + b;
      case '-': return a - b;
      case '*': return a * b;
      case '/':
        if (b === 0) {
          throw new Error('Division by zero');
        }
        return a / b;
      default:
        throw new Error('Unknown operator: ' + op);
    }
  }

  evalExpression(expression: string): number {
    const tokens = this.tokenize(expression);

    const numStack: number[] = [];
    const opStack: string[] = [];

    for (const token of tokens) {
      if (!isNaN(Number(token))) {
        numStack.push(parseFloat(token));
      } else if (token === '(') {
        opStack.push(token);
      } else if (token === ')') {
        while (opStack.length > 0 && opStack[opStack.length - 1] !== '(') {
          this.applyOpFromStacks(numStack, opStack);
        }
        opStack.pop();
      } else {

        while (
          opStack.length > 0 &&
          this.precedence(opStack[opStack.length - 1]) >= this.precedence(token)
        ) {
          this.applyOpFromStacks(numStack, opStack);
        }
        opStack.push(token);
      }
    }

    // 清空运算符栈
    while (opStack.length > 0) {
      this.applyOpFromStacks(numStack, opStack);
    }

    // 栈中最后的元素即为结果
    return ((numStack[0]*1000)/1000);
  }

}

// @Component





    // 示例
    // const expression = "3 4 + 2 * 6 - ( 5 - 1 ) * 2 / 3 - 2";
    // try {
    //   console.log(evalExpression(expression)); // 输出结果
    // } catch (error) {
    //   console.error(error.message);
    // }
