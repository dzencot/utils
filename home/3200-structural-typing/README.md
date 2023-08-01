В JavaScript возможно работать с объектами и классами одинаковым образом. При этом не нужно опираться ни на наследование, ни на интерфейсы. Нужны только ожидаемые поля и методы. Такой подход называют утиной типизацией — duck typing. То что ходит как утка и крякает как утка – утка:

```javascript
const user = {
  firstName: 'Vassiliy',
  lastName: 'Kuzenkov',
  type: 'user'
}

const admin = {
  firstName: 'Kirill',
  lastName: 'Mokevnin',
  type: 'admin'
}

const formatUser = (user) => [user.type, ':', user.firstName, user.lastName].join(' ');

formatUser(user); // ok
formatUser(admin); // ok
```

В языках как Java нам бы потребовалось определить интерфейс, после отдельно имплементировать его для классов `User` и `Admin`. А в параметрах метода форматирования тип аргумента был бы этим интерфейсом.

Другой вариант — написать метод с перегрузкой для этих двух случаев. Языки с таким поведением используют номинативную типизацию — nominative typing.

Чтобы организовать подход утиной типизации в Java, нужно написать много дополнительного кода.

Чтобы упростить переход с JavaScript на TypeScript и использовать проверки до выполнения кода, был выбран подход структурной типизации. С ней мы и познакомимся в этом уроке. 

С помощью структурной типизации мы можем легко переписать наш пример на TypeScript:

```typescript
const user = {
  firstName: 'Vassiliy',
  lastName: 'Kuzenkov',
  type: 'user'
}

const admin = {
  firstName: 'Kirill',
  lastName: 'Mokevnin',
  type: 'admin'
}

const formatUser = (user: { type: string, firstName: string, lastName: string }): string =>
  [user.type, ':', user.firstName, user.lastName].join(' ');

formatUser(user); // ok
formatUser(admin); // ok
```

При этом структурная типизация не защищает нас от наличия дополнительных полей в объекте:

```typescript
const moderator = {
  firstName: 'Danil',
  lastName: 'Polovinkin',
  type: 'moderator',
  email: 'danil@polovinkin.com'
}

const formatUser = (user: { type: string, firstName: string, lastName: string }): string =>
  [user.type, ':', user.firstName, user.lastName].join(' ');

formatUser(moderator); // ok
```

В структурной типизации об объектном типе можно думать, как об описании структуры, которое накладывает ограничения на присваиваемые значения. Или как о множестве объектов, которые могут быть присвоены переменной с таким типом.

![object](https://raw.githubusercontent.com/hexlet-basics/exercises-typescript/main/modules/25-types/60-structural-typing/assets/structual_object.png)

Чем меньше полей в объектном типе, тем менее специфичное ограничение накладывается на присваиваемое значение. На множествах это означает, что объектный тип с дополнительными полями будет подмножеством объектного типа без этих полей. Если говорить о сужении и расширении типа в объектных типах, то дополнительные поля сужают тип.

По аналогиям операций с множествами для объектных типов можно сформировать понимание пересечения и объединения в структурной типизации.

При объединении `|` мы расширяем тип — увеличиваем число допустимых значений для типа. А при пересечении `&` — сужаем. Так мы уменьшаем число допустимых значений:

```typescript
type IntersectionUser = {
  username: string;
  password: string;
} & {
    type: string;
}

const admin: IntersectionUser = { username: 'test', password: 'test', type: 'admin' } // требуется совпадение c объектным типом и слева и справа от оператора &

type UnionUser = {
    username: string;
    password: string;
} | {
    type: string;
}

const user: UnionUser = { username: 'test', type: 'user' } // достаточно совпадения с одним из объектных типов
```

![object intersection](https://raw.githubusercontent.com/hexlet-basics/exercises-typescript/main/modules/25-types/60-structural-typing/assets/structual_object.png)

Попробуйте ответить, что будет, если использовать в пересечении два объектных типа с одинаковым именем поля, но с отличающимися типами. Это распространенная ошибка по невнимательности или из-за недостаточного понимания типов как множеств.

<details>
  <summary>Ответ</summary>
При пересечении объектных типов, если встречаются поля с одинаковыми именами, то они должны быть совместимы — иметь одинаковый тип. Иначе будет ошибка компиляции, так как итоговый тип будет `never`.
</details>
