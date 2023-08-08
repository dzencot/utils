
В TypeScript используется несколько способов типизировать функции, которые передаются как параметры. Самый простой — использовать тип `Function`. Он описывает функцию JavaScript со всеми ее особенностями, включая свойства `bind`, `call` и `apply`.

[//]: # (TODO - автору: что показываем этим фрагментом кода? Нужно сделать подводку)

```typescript
function process(callback: Function) {
  const value = callback();
  // ...
}
```

[//]: # (TODO - автору: нужно описать, что сделали в этом коде )

`Function` отключает проверку типов для вызываемой функции. В итоге количество и тип входных аргументов не проверяются, а результатом работы такой функции будет `any`. Поэтому рекомендуем избегать `Function`.

[//]: # (TODO - автору: что показываем этим фрагментом кода? Нужно сделать подводку)

```typescript
// Сработает, хотя по смыслу не должно
// Внутри Math.round вызовется без аргументов
process(Math.round);
```

[//]: # (TODO - автору: нужно описать, что сделали в этом коде )

Другой способ описывать функции — использовать стрелочную функцию с указанием входных и выходных типов:

```typescript
function process(callback: () => string) {
  // value имеет тип string
  const value = callback();
  // ...
}

process(Math.round);
// Argument of type '(x: number) => number' is not
// assignable to parameter of type '() => string'.
```

Определение стрелочной функции похоже на настоящую, но тут важно не перепутать. Здесь мы видим именно описание типа, а не определение функции.

Рассмотрим еще несколько примеров для закрепления:

```typescript
function process(callback: () => number)
function process(callback: () => string[])
function process(callback: () => { firstName: string; })
```

[//]: # (TODO - автору: нужно описать, что сделали в этом коде )

Пример с параметрами:

```typescript
function process(callback: (n: number) => string) {
  const value = callback(10);
  // ...
}
```

[//]: # (TODO - автору: нужно описать, что сделали в этом коде )

Если определение функции встречается часто, то для него можно создать псевдоним:

```typescript
type myFunction = (n: number) => string;

function process(callback: myFunction) {
  const value = callback(10);
  // ...
}
```

[//]: # (TODO - автору: нужно описать, что сделали в этом коде )

