В JavaScript как ключи в объектах мы можем использовать строки, числа и символы. Ровно такие же ограничения TypeScript накладывает на свои объектные типы, а нам предстоит научиться с ними работать.

В ходе курса мы уже работали с объектными типами и с интерфейсами, в которых имена полей заданы заранее. Давайте теперь познакомимся с синтаксисом для динамических ключей:

```typescript
type dynamicKeysObject = {
  [key: string | number | symbol]: unknown;
};
```

Здесь мы объявили объектный тип `dynamicKeysObject`, в котором ключом может служить любой тип из доступных типов данных `key: string | number | symbol`. Попробуем указать такой тип для переменной:

```typescript
const obj: dynamicKeysObject = {
  name: 'John',
  age: 30,
  0: 'zero',
  [Symbol('secret')]: 'symbol',
};
```

Динамические ключи можно также использовать совместно с указанными явно полями. Тогда ограничения динамических полей также будут распространяться и на них:

```typescript
type MyTheme = {
  palette: {
    primary: 'red' | 'green' | 'blue';
    [key: string]: string;
  },
  [key: string]: unknown;
};

const theme = {
  palette: {
    primary: 'red',
  },
  spacing: {
    small: 8,
  },
} satisfies MyTheme;
```

В примере мы явно указали тип для поля `palette`, получили корректную проверку типа с помощью `satisfies` и при этом оставили достаточно свободы для дальнейшего расширения темы.

Точно такой же синтаксис и поведение у динамических ключей в интерфейсах:

```typescript
interface MyTheme {
  palette: {
    primary: string;
  };
  [key: string]: unknown;
}
```

В классах index signature можно использовать и для обычных, и для `static` полей:

```typescript
class Template {
  static [propName: string]: string | number;

  [key: string]: string;
}

Template.test = 'test';

const template = new Template();
template.test = 'test';
```

## Template String Literal

Динамические ключи полезны там, где нам неизвестны все возможные имена полей объекта, но мы все равно хотим ограничить их тип. В TypeScript тип ключа может также быть и шаблонным литералом. Например, если мы хотим объявить тип слушателя и потребовать, чтобы все его методы начинались со слова `on`:

```typescript
type Listeners = {
  [key: `on${string}`]: (value: unknown) => void
}

const streamListeners: Listeners = {
  onStart() {},
  onFinished() {},
};
```

Литеральный тип ``on${string}`` нам говорит, что мы ожидаем строку по шаблону "начинается с `on` и дальше любая строка". Такая техника называется Template String Literal и используется для того чтобы наложить ограничения при типизации строк.

Если мы рассмотрим типичное веб приложение, то обнаружим, что структура большинства объектов нам известна изначально. Потому использование динамических ключей куда чаще можно увидеть в библиотеках и в ряде вспомогательных функций, которые мы и рассмотрим следующих уроках.