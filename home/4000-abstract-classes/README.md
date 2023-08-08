Когда нам нужно определить общее поведение для нескольких классов, удобно использовать абстрактные классы, которые мы разберем в этом уроке.

Абстрактные классы хоть и не могут быть созданы напрямую, но могут быть наследованы и указать явно, какой метод должен быть реализован в наследниках:

```typescript
abstract class File {
  protected name: string;
  protected size: number;
  constructor(name: string, size: number) {
    this.name = name;
    this.size = size;
  }

  sizeInKb(): number {
    return this.size / 1024;
  }
}

class ImageFile extends File {
  constructor(name: string, size: number) {
    super(name, size);
  }
}
```

Чтобы выносить из классов общую часть кода, абстрактные классы активно используются для построения архитектуры приложения и фреймворков. Например, в React есть класс `Component`, который может быть представлен как абстрактный класс. Мы не можем создать его напрямую, но он требует от наследников реализации метода `render`. Это позволяет создавать компоненты, которые будут рендериться при инициализации:

```typescript
abstract class Component {
  abstract render(): void;

  constructor() {
    this.render();
  }
}
```
