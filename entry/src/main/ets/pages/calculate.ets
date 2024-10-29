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
    // if(op === '('){
    //   return 3
    // }
    return 0;
  }
  applyOpFromStacks(numStack: number[], opStack: string[]): void {
    const op = opStack.pop()!;
    const val2 = numStack.pop()!;
    const val1 = numStack.pop()!;
    numStack.push(this.applyOp(val1, val2, op));
  }
  // applyOp(a: number, b: number, op: string): number {
  //   switch (op) {
  //     case '+': return a + b;
  //     case '-': return a - b;
  //     case '*': return a * b;
  //     case '/':
  //       if (b === 0) {
  //         throw new Error('Division by zero');
  //       }
  //       return a / b;
  //     default:
  //       throw new Error('Unknown operator: ' + op);
  //   }
  // }
  applyOp(a: number, b: number, op: string): number {
    switch (op) {
      case '+':
        return a + b;
      case '-':
        return a - b;
      case '*':
        return a * b;
      case '/':
        if (b === 0) {
          console.error(`Division by zero attempted with operands: ${a}, ${b}`);
          //throw new Error('Division by zero');
          return NaN
        }
        return a / b;
      default:
        console.error(`Unknown operator encountered: ${op}`);
        throw new Error('Unknown operator: ' + op);
        //return NaN
    }
  }


  evalExpression(expression: string): number {
    let  tokens = this.tokenize(expression);

    const numStack: number[] = [];
    const opStack: string[] = [];
    let  j : number = 0
    let fu:number=1
    for (j=0;j<tokens.length;j++) {
      const token=tokens[j]
      // if (token === '-' && (j === 0 || opStack[opStack.length - 1] === '(' || ['+', '-', '*', '/'].includes(opStack[opStack.length - 1]))) {
      //   const nextToken = tokens[j + 1];
      //   if (nextToken && /^\d/.test(nextToken)) {
      //     opStack.push('-' + nextToken);
      //     j++; // 跳过下一个数字
      //   } else {
      //     opStack.push(token); // 保留减号
      //   }
      // } else {
      //   opStack.push(token);
      // }
      if(j===0&&tokens[j]==='-'){
        tokens=tokens.slice(1,tokens.length)
        numStack.push((parseFloat(tokens[j]))*-1)

      }

      else if (!isNaN(Number(token))) {

//tokens[j+2]==='-'&&(
        if(tokens[j+1]==='('||tokens[j+1]==='-'||tokens[j+1]==='+'||tokens[j+1]==='*'||tokens[j+1]==='/'){
          let h=1
          while(tokens[j+h+1]==='(') {
            h++
          }
          if(tokens[j+h+1]==='-'){
            console.log('hhhhhhhhh成了'+h);
            numStack.push(parseFloat(token))
            tokens[j+h+2]='-'+tokens[j+h+2]
            console.log('hhhhhhhhh呵'+ tokens[j+h+2]);
            tokens=tokens.slice(0,j+h+1).concat(tokens.slice(j+h+2,tokens.length))
          }
          else{
            numStack.push(parseFloat(token));
          }

        }else{
          numStack.push(parseFloat(token));
        }

      } else if (token === '(') {
        opStack.push(token);
      } else if (token === ')') {
        while (opStack.length > 0 && opStack[opStack.length - 1] !== '(') {
          console.log('hhhhhh数字1   '+numStack);
          console.log('hhhhhhh符号1   '+opStack)
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
    let i=0
    for(i=0;i<opStack.length;i++){
      if(opStack[i]=== '('){

        console.log('单括号错误'+opStack)
        while (opStack.length > 0 && opStack[opStack.length - 1] !== '(') {
          this.applyOpFromStacks(numStack, opStack);
        }
        opStack.pop();
        break
      }

    }
    console.log('hhhhhhh符号'+opStack)
    console.log('hhhhhhh数字'+numStack)
    while (opStack.length > 0) {
      this.applyOpFromStacks(numStack, opStack);
    }
    // while (opStack.length > 0) {
    //   const op = opStack.pop();
    //   if (op === '(') {
    //     throw new Error('Mismatched parentheses');
    //   }
    //   this.applyOpFromStacks(numStack, opStack);
    // }

    return ((numStack[0]*1000)/1000);
  }

}
