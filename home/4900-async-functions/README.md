`Promise` стали самым популярным способом работы с асинхронным кодом в JavaScript. Они позволяют избежать callback hell, а также упрощают работу с асинхронными функциями. TypeScript также поддерживает привычный синтаксис для работы с Promise в виде async/await и типизацию.

```typescript
const promise = new Promise<number>((resolve, reject) => {
  setTimeout(() => {
    resolve(42);
  }, 1000);
});
```

`Promise` представляет собой дженерик с типом, который будет возвращен в случае успешного выполнения. В примере выше это тип `number`.

Чтобы продолжать работать в одном стиле с функциями, которые принимают callback, мы можем промисифцировать их. Для этого нам нужно обернуть функцию в `Promise`:

```typescript
const wait = (ms: number): Promise<number> => {
  return new Promise((resolve) => {
    const timer = setTimeout(() => {
      resolve(ms);
    }, ms);
  });
};
```

Мы можем и не описывать тип возвращаемого значения, так как TypeScript сможет его вывести из типа, который мы передаем в `Promise`. К тому же из функции, которая помечена как `async`, `Promise` возвращается автоматически, и тип возвращаемого значения будет обернут в `Promise`:

```typescript
const getHours = async () => {
  return new Date().getHours();
};

const hoursPromise: Promise<number> = getHours();
```

Так как `Promise`, как и контейнер, заворачивает значения внутри себя, мы можем использовать `await` для получения значения из него:

```typescript
const hours = await getHours();
```

Как и в JavaScript в TypeScript `await` может использоваться только внутри функций, которые помечены как `async`.

`Promise` вместе с `async/await` позволяют писать асинхронный код в синхронном стиле и сильно упрощают работу с асинхронным кодом. TypeScript поддерживает этот синтаксис и с помощью дженериков позволяет нам использовать его со всей мощью типизации.
