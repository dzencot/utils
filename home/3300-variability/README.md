Когда мы присваиваем значение или передаем аргументы в вызов функции, проверка типов TypeScript проверяет типы на совместимость. При передаче аргументов в функцию проверка выполняется и для типов параметров, и для возвращаемых типов.

Если мы передадим возвращающую `number` функцию для колбека функции-сортировки, которая ожидает возврата `-1 | 0 | 1`, то получим ошибку `Type 'number' is not assignable to type '0 | 1 | -1'.`:

```typescript
type ComparatorCallback = (item1: number, item2: number, index: number) => -1 | 0 | 1
declare function sort(arr: Array<number>, callback: ComparatorCallback): Array<number>

const arr = [1, 2, 3];
const comparator = (item1: number, item2: number) => Math.sign(item1 - item2);
// (item1: number, item2: number) => number;

sort(arr, comparator); // Error: Type 'number' is not assignable to type '0 | 1 | -1'.
```

Множество значений из объединения трех литеральных типов `-1 | 0 | 1` является подмножеством `number`. Но из ошибки можно понять, что возвращаемый тип должен быть либо таким же, либо более узким. Такое поведение проверки типов называется **ковариантностью**.

Чтобы решить проблему с `ComparatorCallback`, нам нужно сузить возвращаемый тип функции `comparator` до `-1 | 0 | 1` или более узкого. Перепишем код без `Math.sign`, чтобы вернуть нужный тип:

```typescript
type ComparatorCallback = (item1: number, item2: number, index: number) => -1 | 0 | 1
declare function sort(arr: Array<number>, callback: ComparatorCallback): Array<number>

const arr = [1, 2, 3];
const comparator = (item1: number, item2: number) => {
// (item1: number, item2: number) => -1 | 0 | 1;
    if (item1 === item2) {
        return 0;
    }

    return item1 > item2 ? 1 : -1;
};

sort(arr, comparator);
```

Попробуйте самостоятельно объяснить поведение проверки типов через вариантность в следующем примере:

```typescript
type Formatter = (val: string) => string;

const formatToConcrete: Formatter = (): 'test' => 'test';
const formatToNumber: Formatter = (val: '1') => val; // Error!
```

<details>
  <summary>Ответ</summary>
  Тип параметров может быть шире, а тип на выходе — уже.
  В примере `formatToConcrete` не принимает никаких параметров. Это дает более широкий тип, нежели требуемый `string`. А возвращает более узкий литеральный тип. `formatToNumber` ожидает более узкий тип на входе, поэтому и возникает ошибка.
</details>

Если при работе с TypeScript учитывать наследие JavaScript с утиной типизацией, то все становится на свои места.

Чтобы код не упал с ошибкой, достаточно проверки на наличие полей или методов нужных типов. А чтобы получить гарантии во внешнем мире, нужно, чтобы переменная попадала под внешние ограничения. Для этого тип должен быть более узким или таким же.
