В этом уроке мы разберем наследование. Это механизм, который позволяет создавать подклассы на основе уже существующих классов. Подклассы наследуют свойства и методы родительского класса и могут расширять их.

В TypeScript наследование реализуется с помощью ключевого слова `extends`:

```typescript
class File {
  constructor(public name: string, public size: number) {}
}

class ImageFile extends File {
  constructor(name: string, size: number, public width: number, public height: number) {
    super(name, size);
  }
}
```

Наследоваться можно только от одного класса. Но цепочка наследования может быть бесконечной. Например, класс `ImageFile` наследуется от класса `File`, который может наследоваться от другого класса и так далее.

Вся цепочка наследования образует иерархию классов. Так как классы могут использоваться и как типы, иерархия классов полностью совпадает с иерархией типов. Подкласс является подтипом базового класса и может использоваться вместо него, при этом задавать более строгие ограничения.

```typescript
const file = new File('open-world.jpeg', 1000);
const image = new ImageFile('open-world.jpeg', 1000, 100, 100);

const showImage = (image: ImageFile) => {
...
};
showImage(file); // Error
```

При наследовании можно переопределять методы родительского класса. При этом нужно либо сохранить сигнатуру метода, либо соблюдать некоторые правила:

- Типы параметров переопределенного метода бивариантны
- Тип возвращаемого значения переопределенного метода ковариантен

Родительский метод принимает `string` и возвращает `string`. Переопределенный метод должен иметь более широкий или более узкий тип, например, `string | null` или `'some string'`. Возвращать же должен более узкий тип, например, `'some string'`:

```typescript
class FileFactory {
  createFile(name: string, size: number): File {
    return new File(name, size);
  }
}

class ImageFileFactory extends FileFactory {
  createFile(name: string, size: number): ImageFile { // OK
    return new ImageFile(name, size, 100, 100);
  }
  createFile(name: 'file', size: number): File { // OK
    return new ImageFile(name, size, 100, 100);
  }
  createFile(name: number, size: number): File { // Error!
    return new ImageFile(name, size, 100, 100);
  }
  createFile(name: string, size: number): {} { // Error!
    return new ImageFile(name, size, 100, 100);
  }
}
```
