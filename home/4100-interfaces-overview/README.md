В этом уроке мы поговорим об интерфейсе. Это конструкция языка TypeScript, которая используется, чтобы описывать объекты и функции.

Рассмотрим следующий пример:

```typescript
interface IUser {
  firstName: string;
  pointsCount: number;
}

const user: IUser = {
  firstName: 'Mark',
  pointsCount: 100,
};
```

В данном фрагменте мы создали интерфейс и реализовали на его основе объекта user.

Интерфейс выглядит как определение объектного типа. Объектные типы и интерфейсы взаимозаменяемы почти во всех ситуациях. Сравним с примером выше:

```typescript
type User = {
  firstName: string;
  pointsCount: number;
}

const user: User = {
  firstName: 'Mark',
  pointsCount: 100,
};
```

Здесь мы реализовали такой же объект, но уже на основе типа, а не интерфейса. Разницы почти нет.

Документация TypeScript говорит о том, что мы можем выбирать, что использовать — тип или интерфейс. Выбор зависит от ситуации. В таком случае возникает вопрос, зачем нужна новая конструкция (интерфейсы), когда уже есть типы?

Хотя интерфейсы и типы во многом похожи, есть отличия, на основе которых мы и можем выбирать, что именно следует использовать в конкретном случае. Главная особенность интерфейсов связана с классами. Классы, которые реализуют интерфейсы, содержат внутри себя свойства и методы, указанные в реализуемом интерфейсе:

```typescript
interface Countable {
  count(): number;
}

class SchoolClass implements Countable {
  // Тут какая-то логика
  count(): number {
    // Обязательно создать этот метод, так как он указан в интерфейсе
  }
}

const sc = new SchoolClass();
// Возвращает число студентов в классе
sc.count();
```

В этом примере мы реализовали класс на основе интерфейса. Теперь во всех функциях, где объекты используются только для того, чтобы посчитать количество чего-либо внутри них, можно указывать `Countable` вместо `SchoolClass`:

```typescript
// А не function doSomething(obj: SchoolClass)
function doSomething(obj: Countable) {
  // Где-то внутри вызывается
  obj.count();
}
```

Так благодаря интерфейсам функция становится более универсальной. Мы можем передать любые объекты, соответствующие `Countable`, а не только `SchoolClass`. В программировании такая возможность называется полиморфизмом подтипов ([Subtyping](https://en.wikipedia.org/wiki/Subtyping)).