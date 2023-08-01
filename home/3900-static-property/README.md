Иногда нам требуется задать свойство или метод, который будет общим для всех экземпляров этого класса. Например, чтобы определить, является ли объект экземпляром класса. В таком случае при объявлении метода мы можем указать ключевое слово `static`, и он станет доступен через имя класса:

```typescript
class File {
  private static readonly maxFileSize = 1000;
  static isFile(file: File): boolean {
    return file instanceof File;
  }

  protected static isFileTooBig(size: number): boolean {
    return size > File.maxFileSize;
  }

  constructor(private name: string, private size: number) {
    if (File.isFileTooBig(size)) {
      throw new Error('File is too big');
    }
  }
}

File.isFile(new File('open-world.jpeg', 1000)); // true
```

Статическим методам и свойствам также можно назначить модификаторы доступа `public`, `protected` и `private` и модификатор неизменяемости `readonly`. Это позволяет ограничить использование свойств и методов только текущим классом или наследниками.

В отличии от JavaScript в TypeScript статические свойства и методы не могут быть переопределены в подклассах:

```typescript
class File {
  static maxFileSize = 1000;
  static isFile(file: File): boolean {
    return file instanceof File;
  }
}

class ImageFile extends File {
  static maxFileSize = 2000; // Error!
  static isFile(file: File): boolean { // Error!
    return file instanceof ImageFile;
  }
}
```

Такой код не удастся скомпилировать. При этом остается доступ к статическим свойствам и методам родительского класса:

```typescript
const file = new ImageFile();
console.log(ImageFile.maxFileSize); // 1000
console.log(ImageFile.isFile(file)); // true
```
