В этом уроке разберем типы объекта. Они состоят из типов всех входящих в него свойств. Выводятся типы автоматически:

```typescript
// Тип: { firstName: string, pointsCount: number }
const user = {
  firstName: 'Mike',
  pointsCount: 1000,
};

// Поменять тип свойств нельзя
// Type 'number' is not assignable to type 'string'.
user.firstName = 7;
```

TypeScript не позволяет обращаться к несуществующим свойствам. Это значит, что структура любого объекта должна быть задана при его инициализации:

[//]: # ( TODO - автору: а почему в этом случае структура объекта должна быть задана при инициализации? Нужно подробнее расскрыть мысль - обяъснить это. Студенту может быть не ясно. )

```typescript
// Property 'age' does not exist on type '{ firstName: string, pointsCount: number; }'.
user.age = 100;
```

Чтобы принять такой объект в функцию как параметр, нужно указать его структуру в описании функции:

```typescript
// Свойства в описании типа разделяются через запятую (,)
function doSomething(user: { firstName: string, pointsCount: number }) {
  // ...
}
```

Теперь внутрь можно передавать любой объект, который совпадает по свойствам:

```typescript
doSomething({ firstName: 'Alice', pointsCount: 2000 });
doSomething({ firstName: 'Bob', pointsCount: 1800 });

// Так нельзя
doSomething({ firstName: 'Bob' });
// И так тоже
doSomething({ firstName: 'Bob', pointsCount: 1800, key: 'another' });
```

Как и в случае примитивных типов данных, ни null, ни undefined по умолчанию не разрешены. Чтобы изменить это поведение, нужно добавить опциональность:

```typescript
// firstName может быть undefined
// pointsCount может быть null
function doSomething(user: { firstName?: string, pointsCount: number | null }) {
  // ...
}
```
