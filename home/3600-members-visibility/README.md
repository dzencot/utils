В некоторых случаях свойства и методы в классе создаются только для внутреннего использования. Разработчики не хотят давать возможность вызывать их снаружи, иначе их случайно могут начать использовать, что не планировалось.

В языках с классами принято разделять свойства на публичные, приватные и защищенные. Первые доступны для всех, вторые могут использоваться только внутри класса, а третьи — внутри класса и в его наследниках. В этом уроке разберем каждый из этих видов.

## Публичные свойства

По умолчанию в TypeScript все свойства публичные. Это можно обозначить явно с помощью ключевого слова `public`:

```typescript
class Point {
  public x: number;
  public y: number;

  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }

  public someMethod() {
    // some logic
  }
}
```

## Приватные свойства

Также свойства можно сделать приватными. Тогда пропадет возможность обращаться к ним снаружи напрямую:

```typescript
class Point {
  private x: number;
  private y: number;

  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}

const p = new Point(10, 8);
p.x; // Error!
p.y; // Error!
```

## Защищенные свойства

И наконец, свойства можно сделать защищенными. Это значит, что они доступны внутри класса и в наследниках:

```typescript
class Point {
  protected x: number;
  protected y: number;

  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}

class Point3D extends Point {
  protected z: number;

  constructor(x: number, y: number, z: number) {
    super(x, y);
    this.z = z;
  }

  public getCoordinates() {
    return [this.x, this.y, this.z]; // OK
  }
}

const p = new Point3D(10, 8, 5);
p.x; // Error!
p.y; // Error!
p.z; // Error!
```
