Дженерик-классы, как и дженерик функции, позволяют создавать классы, которые могут работать с разными типами данных. Например, класс `Triple` может хранить три значения любого типа. В этом случае вместо того, чтобы создавать классы для каждого типа, можно создать обобщенный класс, который будет работать с любым типом данных.

```typescript
class Triple<T, U, V> {
  constructor(protected first: T, protected second: U, protected third: V) {}

  getFirst(): T {
    return this.first;
  }

  getSecond(): U {
    return this.second;
  }

  getThird(): V {
    return this.third;
  }
}
```

В этом примере класс `Triple` — дженерик-класс, в который мы можем поместить любые типы данных. При этом у нас остаются гарантии безопасности и вывод типов, которые мы получили при использовании обобщенных функций:

```typescript
const triple = new Triple(1, 'string', null);
const first = triple.getFirst(); // number
const second = triple.getSecond(); // string
```

Также можно наследоваться от обобщенных классов. Например, класс `Pair` может быть наследником класса `Triple`, который хранит два значения любого типа:

```typescript
class Pair<T, U> extends Triple<T, U, never> {
  constructor(first: T, second: U) {
    super(first, second, undefined as never);
  }

  getFirst(): T {
    return this.first;
  }

  getSecond(): U {
    return this.second;
  }
}
```

Здесь мы использовали приведение к типу `never`, чтобы пометить третий параметр как отсутствующий.

Как и обычные классы, обобщенные классы также можно использовать в качестве типов параметров функций:

```typescript
function swap<T, U>(pair: Pair<T, U>): Pair<U, T> {
  return new Pair(pair.getSecond(), pair.getFirst());
}
```

Дженерик-классы полезны, когда нам нужно создать какой-нибудь контейнер для хранения данных, как в примере с классом `Pair`. `Array`, `Map`, `Set` — это дженерик-классы, которые хранят элементы заданного типа.
