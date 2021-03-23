# Prop

https://cn.vuejs.org/v2/guide/components-props.html

### Prop写法

HTML 中的 attribute 名是大小写不敏感的，所以浏览器会把所有大写字符解释为小写字符。这意味着当你使用 DOM 中的模板时，camelCase (驼峰命名法) 的 prop 名需要使用其等价的 kebab-case (短横线分隔命名) 命名：**——标签、标签属性都是大小写不敏感的，而属性值是敏感的，比如：class="className"**



```html
Vue.component('blog-post', {
  // 在 JavaScript 中是 camelCase 的
  props: ['postTitle'],
  template: '<h3>{{ postTitle }}</h3>'
})
<!-- 在 HTML 中是 kebab-case 的 -->
<blog-post post-title="hello!"></blog-post>
```

重申一次，如果你使用字符串模板，那么这个限制就不存在了。——？？？

也就是说：

标签的上驼峰写法，会被浏览器解析为小写：

```html
<blog-post postTitle="hello!"></blog-post>

解析为：

<blog-post posttitle="hello!"></blog-post>
```

由于组件都会经过vue解析，vue最想接受一个`postTitle`，次想接收一个`posttitle`。但标签的attribute会被浏览器解析为小写的，所以无法传入驼峰写法。但是我们可以传入一个kebab-case (短横线分隔命名) ，让vue经过处理为驼峰写法。**——Vue的特殊处理，将标签上的短横线与组件的props的小驼峰对应**



以下是vue接收一个`posttitle`

```html
  <div id="app">
    <blog-post posttitle="hello!"></blog-post>
  </div>
  <script>
    Vue.component('blog-post', {
      props: ['posttitle'],
      template: `<h3>{{ posttitle }}</h3>`
    })
    new Vue({
      el: '#app'
    })
  </script>
```



以下是vue接收一个驼峰`postTitle`

```html
  <div id="app">
    <blog-post post-title="hello!"></blog-post>
  </div>
  <script>
    Vue.component('blog-post', {
      props: ['postTitle'],
      template: `<h3>{{ postTitle }}</h3>`
    })
    new Vue({
      el: '#app'
    })
  </script>
```



### Prop类型——想接收的数据，父组件未必会全部传过来

字符串数组形式列出的 prop：

```js
props: ['title', 'likes', 'isPublished', 'commentIds', 'author']
```

通常你希望每个 prop 都有指定的值类型。这时，你可以以对象形式列出 prop，这些 property 的名称和值分别是 prop 各自的名称和类型：

```js
props: {
  title: String,
  likes: Number,
  isPublished: Boolean,
  commentIds: Array,
  author: Object,
  callback: Function,
  contactsPromise: Promise // or any other constructor
}
```



**传递静态或动态Prop**

实际上*任何*类型的值都可以传给一个 prop。

**静态Prop**

```html
<blog-post title="My journey with Vue"></blog-post>
```

**动态Prop**——**通过 `v-bind` 动态赋值**

```html
<!-- 动态赋予一个变量的值 -->
<blog-post v-bind:title="post.title"></blog-post>

<!-- 动态赋予一个复杂表达式的值 -->
<blog-post
  v-bind:title="post.title + ' by ' + post.author.name"
></blog-post>
```



注意：v-bind来告诉vue这是一个 JavaScript 表达式而不是一个字符串，所以在传非字符串时，都需要使用到v-bind来动态传入值。



**传入一个数字**

```html
<!-- 即便 `42` 是静态的，我们仍然需要 `v-bind` 来告诉 Vue -->
<!-- 这是一个 JavaScript 表达式而不是一个字符串。-->
<blog-post v-bind:likes="42"></blog-post>

<!-- 用一个变量进行动态赋值。-->
<blog-post v-bind:likes="post.likes"></blog-post>
```

**传入一个布尔值**

```html
<!-- 包含该 prop 没有值的情况在内，都意味着 `true`。-->
<blog-post is-published></blog-post>

<!-- 即便 `false` 是静态的，我们仍然需要 `v-bind` 来告诉 Vue -->
<!-- 这是一个 JavaScript 表达式而不是一个字符串。-->
<blog-post v-bind:is-published="false"></blog-post>

<!-- 用一个变量进行动态赋值。-->
<blog-post v-bind:is-published="post.isPublished"></blog-post>
```

**传入一个数组**

```xml
<!-- 即便数组是静态的，我们仍然需要 `v-bind` 来告诉 Vue -->
<!-- 这是一个 JavaScript 表达式而不是一个字符串。-->
<blog-post v-bind:comment-ids="[234, 266, 273]"></blog-post>

<!-- 用一个变量进行动态赋值。-->
<blog-post v-bind:comment-ids="post.commentIds"></blog-post>
```

**传入一个对象**

```html
<!-- 即便对象是静态的，我们仍然需要 `v-bind` 来告诉 Vue -->
<!-- 这是一个 JavaScript 表达式而不是一个字符串。-->
<blog-post
  v-bind:author="{
    name: 'Veronica',
    company: 'Veridian Dynamics'
  }"
></blog-post>

<!-- 用一个变量进行动态赋值。-->
<blog-post v-bind:author="post.author"></blog-post>
```

**传入一个对象的所有 property**

如果你想要将一个对象的所有 property 都作为 prop 传入，你可以使用不带参数的 `v-bind` (取代 `v-bind:prop-name`)。例如，对于一个给定的对象 `post`：

```js
post: {
  id: 1,
  title: 'My Journey with Vue'
}
```

下面的模板：

```html
<blog-post v-bind="post"></blog-post>
```

等价于：

```html
<blog-post
  v-bind:id="post.id"
  v-bind:title="post.title"
></blog-post>
```



### 单向数据流

所有的 prop 都使得其父子 prop 之间形成了一个**单向下行绑定**：父级 prop 的更新会向下流动到子组件中，但是反过来则不行。意味着，每次父级组件发生变更时，子组件中所有的 prop 都将会刷新为最新的值。

常见以下用法：

1. **这个 prop 用来传递一个初始值；这个子组件接下来希望将其作为一个本地的 prop 数据来使用。**在这种情况下，最好定义一个本地的 data property 并将这个 prop 用作其初始值：

   **注意：**因为在Vue实例初始化时，已经在子组件中申明了`counter`变量，所以该变量具有响应式。该变量是地址也指向父组件传入的值，所以通过该变量修改引用地址内的值，也会改变父组件传入的值，改变父组件的数据。

   但是子组件不能修改父组件传入值的地址。

   ```js
   props: ['initialCounter'],
   data: function () {
     return {
       counter: this.initialCounter
     }
   }
   ```

2. **这个 prop 以一种原始的值传入且需要进行转换。**在这种情况下，最好使用这个 prop 的值来定义一个计算属性：

   ```js
   props: ['size'],
   computed: {
     normalizedSize: function () {
       return this.size.trim().toLowerCase()
     }
   }
   ```



**实例：父组件给子组件传值——通过标签的attribute属性值传给子组件的props。可以在data函数中重命名props接收到属性**

父组件`blog-post`从标签attribute获取静态数据postTitle（由组件的props属性来接受标签attribute传递的值），父组件templete中使用了子组件`blog-a`，同时通过标签attribute动态传值，将父组件用于的数据传给子组件。

```html
  <div id="app">
    <blog-post post-title="hello!"></blog-post>
  </div>
  <script>
    var blogA = {
      props: ['postTitle'],
      data() {
        return {
          text: this.postTitle
        }
      },
      template: '<a href="www.baidu.com">百度一下{{postTitle}}</a>'
    }
    Vue.component('blog-post', {
      props: ['postTitle'],
      components: {
        'blog-a': blogA
      },
      template: `<h3><blog-a v-bind:post-title="postTitle"></blog-a></h3>`
    })
    new Vue({
      el: '#app'
    })
  </script>
```

上面实例通过父组件的attribute获取的值，传给子组件的。下面实例，通过父组件的data内的值，传给子组件。——实际上，对于组件而言，props内的值和data内的值，都挂载组件自身。注意使用这些值时，什么时候需要用this，什么时候不用this？

答：js中使用this来调用；而在标签上不需要使用this，比如模板语法和标签属性值。

```html
  <div id="app">
    <blog-post post-title="hello!"></blog-post>
  </div>
  <script>
    var blogA = {
      props: ['postTitle'],
      data() {
        return {
          text: this.postTitle
        }
      },
      template: '<a href="www.baidu.com">百度一下{{text}}</a>'
    }
    Vue.component('blog-post', {
      props: ['postTitle'],
      data(){
        return {
          name: 'zhu'
        }
      },
      components: {
        'blog-a': blogA
      },
      template: `<h3><blog-a v-bind:post-title="name"></blog-a></h3>`
    })
    new Vue({
      el: '#app'
    })
  </script>
```

### 组件传值

通过组件的标签往下传值的。

从vue实例开始：可以将vue实例的data、computed等数据，通过组件标签传递给组件；组件通过props来接收，组件props接收到的数据可以放入到组件的data或computed计算属性中。

从父组件开始：props接收的数据、data中的数据、computed计算属性，都可以通过组件标签传递给子组件。由子组件的props接收。



### Prop验证——可以不传，但是传了，一定要传正确的数据类型

组件期望传入的值，是什么样的类型。

```js
Vue.component('my-component', {
  props: {
    // 基础的类型检查 (`null` 和 `undefined` 会通过任何类型验证)
    propA: Number,
    // 多个可能的类型
    propB: [String, Number],
    // 必填的字符串
    propC: {
      type: String,
      required: true
    },
    // 带有默认值的数字
    propD: {
      type: Number,
      default: 100
    },
    // 带有默认值的对象
    propE: {
      type: Object,
      // 对象或数组默认值必须从一个工厂函数获取
      default: function () {
        return { message: 'hello' }
      }
    },
    // 自定义验证函数
    propF: {
      validator: function (value) {
        // 这个值必须匹配下列字符串中的一个
        return ['success', 'warning', 'danger'].indexOf(value) !== -1
      }
    }
  }
})
```

当 prop 验证失败的时候，(开发环境构建版本的) Vue 将会产生一个控制台的警告。

注意：那些 prop 会在一个**组件实例**创建**之前**进行验证，所以组件实例的 property (如 `data`、`computed` 等) 在 `default` 或 `validator` 函数中是不可用的。

在组件实例创建前，组件中的传值会进行验证，且实例的data、computed等不能在default或validator函数中不可用——**undefined**

示例：

```html
  <div id="app">
    <span>{{msg}}</span>
    <blog-post prop-c="hello!" ></blog-post>
  </div>
  <script>
    Vue.component('blog-post', {
      props: {
        propA: Number,
        propB: [String, Number],
        propC: {
          type: String,
          required: true
        },
        propD: {
          type: Number,
          default: this.age
        },
        propE: {
          type: Object,
          default: function () {
            console.log(this.age) //undefined
            return {
              message: this.propC //从组件标签上传入的
            }
          }
        },
        propF: {
          validator: function (value) {
            
            return ['success', 'warning', 'danger'].indexOf(value) !== -1
          }
        }
      },
      data (){
        return {
          age: 24
        }
      },
      template: `<span>{{propE}}{{propA}}{{age}}</span>`
    })

    var vm = new Vue({
      el: '#app',
      data: {
        msg: {
          name: 'zhuyuzhu'
        }
      }
    })

  </script>
```



**prop可验证的数据类型**

`type` 可以是下列原生构造函数中的一个：

- `String`
- `Number`
- `Boolean`
- `Array`
- `Object`
- `Date`
- `Function`
- `Symbol`

额外的，`type` 还可以是一个自定义的构造函数，并且通过 `instanceof` 来进行检查确认。例如，给定下列现成的构造函数：

```js
function Person (firstName, lastName) {
  this.firstName = firstName
  this.lastName = lastName
}
```

你可以使用：

```js
Vue.component('blog-post', {
  props: {
    author: Person
  }
})
```

来验证 `author` prop 的值是否是通过 `new Person` 创建的。



### Prop影响组件上的attribute——不太理解



**非 Prop 的 Attribute**

一个非 prop 的 attribute 是指传向一个组件，但是该组件并没有相应 prop 定义的 attribute。

因为显式定义的 prop 适用于向一个子组件传入信息，然而组件库的作者并不总能预见组件会被用于怎样的场景。这也是为什么组件可以接受任意的 attribute，而这些 attribute 会被添加到这个组件的根元素上。

例如，想象一下你通过一个 Bootstrap 插件使用了一个第三方的 `<bootstrap-date-input>` 组件，这个插件需要在其 `<input>` 上用到一个 `data-date-picker` attribute。我们可以将这个 attribute 添加到你的组件实例上：

```html
<bootstrap-date-input data-date-picker="activated"></bootstrap-date-input>
```

然后这个 `data-date-picker="activated"` attribute 就会自动添加到 `<bootstrap-date-input>` 的根元素上。



**替换/合并已有的 Attribute**

想象一下 `<bootstrap-date-input>` 的模板是这样的：

```html
<input type="date" class="form-control">
```

为了给我们的日期选择器插件定制一个主题，我们可能需要像这样添加一个特别的类名：

```html
<bootstrap-date-input
  data-date-picker="activated"
  class="date-picker-theme-dark"
></bootstrap-date-input>
```

在这种情况下，我们定义了两个不同的 `class` 的值：

- `form-control`，这是在组件的模板内设置好的
- `date-picker-theme-dark`，这是从组件的父级传入的

对于绝大多数 attribute 来说，从外部提供给组件的值会替换掉组件内部设置好的值。所以如果传入 `type="text"` 就会替换掉 `type="date"` 并把它破坏！庆幸的是，`class` 和 `style` attribute 会稍微智能一些，即两边的值会被合并起来，从而得到最终的值：`form-control date-picker-theme-dark`。



**禁用 Attribute 继承**

如果你**不**希望组件的根元素继承 attribute，你可以在组件的选项中设置 `inheritAttrs: false`。例如：

```js
Vue.component('my-component', {
  inheritAttrs: false,
  // ...
})
```

这尤其适合配合实例的 `$attrs` property 使用，该 property 包含了传递给一个组件的 attribute 名和 attribute 值，例如：

```js
{
  required: true,
  placeholder: 'Enter your username'
}
```

有了 `inheritAttrs: false` 和 `$attrs`，你就可以手动决定这些 attribute 会被赋予哪个元素。在撰写[基础组件](https://cn.vuejs.org/v2/style-guide/#基础组件名-强烈推荐)的时候是常会用到的：

```js
Vue.component('base-input', {
  inheritAttrs: false,
  props: ['label', 'value'],
  template: `
    <label>
      {{ label }}
      <input
        v-bind="$attrs"
        v-bind:value="value"
        v-on:input="$emit('input', $event.target.value)"
      >
    </label>
  `
})
```

注意 `inheritAttrs: false` 选项**不会**影响 `style` 和 `class` 的绑定。

这个模式允许你在使用基础组件的时候更像是使用原始的 HTML 元素，而不会担心哪个元素是真正的根元素：

```html
<base-input
  v-model="username"
  required
  placeholder="Enter your username"
></base-input>
```