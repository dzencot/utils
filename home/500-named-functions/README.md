В определении переменной мы обычно не указываем ее тип, так как он выводится автоматически. С функциями это не работает. Для них нужно обязательно указывать типы всех входных параметров.

В этом уроке разберем, как сделать параметр необязательным, нужно ли что-то делать со значением переменной по умолчанию, и как выводить тип возвращаемого значения.

## Обязательный параметр

Вызовем функцию и укажем тип параметра:

```typescript
function getGreetingPhrase(name: string) {
  return `Hello, ${name.toUpperCase()}!`;
}
```

При таком указании параметр будет обязательным. Если вызвать функцию без параметра, это приведет к ошибке компиляции:

```typescript
// Expected 1 arguments, but got 0.
getGreetingPhrase();
```

## Необязательный параметр

Чтобы сделать параметр необязательным, нужно добавить знак «?» после имени переменной:

```typescript
function getGreetingPhrase(name?: string) {
  return `Hello, ${name ? name.toUpperCase() : 'Guest'}!`;
}

getGreetingPhrase('Mike'); // Hello, MIKE!
getGreetingPhrase(); // Hello, Guest!
```

В таком случае тип переменной `name` становится составным (Union Type): `string | undefined` — строка или undefined.

Необязательный параметр может быть `undefined`, но не `null`. Чтобы добавить `null`, нужно изменить определение так:

```typescript
function getGreetingPhrase(name?: string | null) {
  return `Hello, ${name ? name.toUpperCase() : 'Guest'}!`;
}
```

Здесь мы расширили определение типа переменной `name` до `string | undefined | null`.

## Значение по умолчанию

Со значением по умолчанию не нужно ничего указывать дополнительно. Значение задается как в JavaScript. Сама переменная автоматически становится необязательной, и тип выводится, исходя из переданного значения:

```typescript
function getGreetingPhrase(name = 'Guest') {
  return `Hello, ${name.toUpperCase()}!`;
}

getGreetingPhrase() // Hello, GUEST!
```

## Тип возвращаемого значения

Во многих случаях TypeScript выводит тип возвращаемого значения самостоятельно, но его можно указывать явно:

```typescript
function getGreetingPhrase(name: string): string {
  return `Hello, ${name.toUpperCase()}!`;
}
```

Возвращаемый тип может выводиться, но иногда из этого [получается](https://stackoverflow.com/questions/70001511/why-specify-function-return-types) не то, что мы ожидаем. Поэтому мы рекомендуем всегда проставлять тип. Это упрощает документирование и защищает код от случайных изменений.
