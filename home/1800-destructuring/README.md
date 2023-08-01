В этом уроке разберем деструктуризацию в определении функций. Это механизм, с помощью которого переданный как аргумент объект распаковывается, а его части присваиваются локальным переменным функции. В JavaScript он выглядит так:

  ```javascript
  // Обычное определение
  const foo = (user) => {
    console.log(user.firstName, user.age);
  };

  // Деструктурированный объект
  const foo = ({ firstName, age }) => {
    console.log(firstName, age);
  };

  const user = { firstName: 'Smith', age: 30 };
  foo(user);
  ```

  Деструктурированный объект визуально похож на параметры функции. При этом он все равно остается объектом, поэтому в TypeScript его тип описывается после закрывающей фигурной скобки:

  ```typescript
  // Обычное определение
  function foo(user: { firstName: string, age: number }) {
    console.log(user.firstName, user.age);
  }

  // Деструктурированный объект
  function foo({ firstName, age }: { firstName: string, age: number }) {
    console.log(firstName, age);
  }
  ```
  
  [//]: # (TODO - автору: описать код - на что тут нужно обратить внимание?)
  
  Если вынести определение типа в алиас, то можно сделать код поменьше:

  ```typescript
  type User = {
    firstName: string;
    age: number;
  }

  function foo({ firstName, age }: User) {
    console.log(firstName, age);
  }
  ```
  
  [//]: # (TODO - автору: описать код - на что тут нужно обратить внимание?)
  
  То же самое применимо и к массивам:

  ```typescript
  // Обычное определение
  function foo(point: number[]) {
    console.log(point);
  }

  // Деструктурированный массив
  function foo([x, y]: number[]) {
    console.log(x, y);
  }

  // С алиасом
  type Point = number[];

  function foo([x, y]: Point) {
    console.log(x, y);
  }
  ```
  
  [//]: # (TODO - автору: описать код - на что тут нужно обратить внимание?)