Чтобы при работе с объектными типами избежать дублирования полей и переиспользовать существующие мы можем использовать механизм поиска типов (Lookup Types):

```typescript
interface Person {
  name: string;
  age: number;
  location?: {
    country: string;
    city: string;
  };
}

interface PersonDetails {
  location: Person['location'];
}
```

Конструкция `Type[Key]` выглядит и работает также, как получение значения объекта по ключу в JavaScript, однако обратите внимание, что доступ через точку тут не сработает.

Lookup Types позволяет также получить объединение типов из объекта по нескольким известным ключам объединенным с помощью вертикальной черты `|`:

```typescript
type User = {
  id: number;
  name: string;
  email: string;
}

type UserFields = User['id' | 'name' | 'email']; // string | number
```

Чтобы получить объединение всех ключей из объекта мы можем использовать оператор `keyof`, давайте упростим наш пример:

```typescript
type User = {
  id: number;
  name: string;
  email: string;
}

type UserFields = User[keyof User]; // string | number
```

Чтобы не дублировать полностью все поля одного объектного типа в другом используются вспомогательные типы `Pick<Type, Keys>` и `Omit<Type, Keys>`. `Pick<Type, Keys>` создает объектный тип с ключами `Keys` из `Type`, а `Omit<Type, Keys>` создает объектный тип, из которого исключаются ключи `Keys` из `Type`:

```typescript
interface Person {
  name: string;
  age: number;
  location?: string;
}

const details: Pick<Person, 'name' | 'age'> = {
  name: 'John',
  age: 42,
};

const details2: Omit<Person, 'location'> = {
  name: 'John',
  age: 42,
};
```

В этом примере тип полученный в результате `Pick<Person, 'name' | 'age'>` и `Omit<Person, 'location'>` будет одним и тем же.

Все Utility Types в TypeScript написаны при помощи встроенных конструкций. Мы уже изучили достаточно много концепций TypeScript, чтобы начать с ними разбираться. Потому мы можем задаться резонным вопросом, как же они реализованны. Рассмотрим как реализован тип `Pick`:

```typescript
type Pick<T, K extends keyof T> = {
  [P in K]: T[P];
};
```

`Pick<T, K>` - дженерик тип с двумя параметрами: `T` и `K`. На `K` мы также наложили ограничение `extends keyof T`, что означает, что `K` должно содержать перечисление ключей из `T`.
Далее с помощью оператора `in` выполняется перебор по всем элементам перечисления. Каждый такой полученный элемент становится ключом, а для значения мы ищем подходящий тип в объектом типе `T[P]`.

Операторы `keyof` (Lookup Types) и `in` (Mapped Types) часто идут рука об руку. С помощью `keyof` мы получаем доступ ко всем именам свойств объектного типа, а благодаря `in` можем циклически пройти по всем свойствам. Эти две операции являются ключевыми при создании своих вспомогательных типов при работе с объектными типами данных.
