# 组件插槽component Slots



https://cn.vuejs.org/v2/guide/components-slots.html



> 在 2.6.0 中，我们为具名插槽和作用域插槽引入了一个新的统一的语法 (即 `v-slot` 指令)。它取代了 `slot` 和 `slot-scope` 这两个目前已被废弃但未被移除且仍在[文档中](https://cn.vuejs.org/v2/guide/components-slots.html#废弃了的语法)的 attribute。新语法的由来可查阅这份 [RFC](https://github.com/vuejs/rfcs/blob/master/active-rfcs/0001-new-slot-syntax.md)。

### 插槽内容

Vue 实现了一套**内容分发**的 API，这套 API 的设计灵感源自 [Web Components 规范草案](https://github.com/w3c/webcomponents/blob/gh-pages/proposals/Slots-Proposal.md)，将 `<slot>` 元素作为承载分发内容的出口。



**使用：**插槽slot在组件的template中，组件使用时，组件名为标签名。可以通过在组件标签内添加文本内容或者子标签，这些内容将由组件的插槽接收。

如果 `<navigation-link>` 的 `template` 中**没有**包含一个 `<slot>` 元素，则该组件起始标签和结束标签之间的任何内容都会被抛弃。

**记忆：**组件标签内的内容，先放入template的slot中，再把template的内容完全替换到组件标签的位置。当然只有组件标签（而非组件标签内，要填入到slot中的内容）可以传入一些值。

```html
    <blog-post prop-c="hello!" >
      <div>
        <span>1</span>
        <span>2</span>
      </div>
    </blog-post>
```

```js
      template: `<div>
        <span>0</span>
        <slot>插槽接收自定义标签的内容</slot>
        </div>`
```



### 作用域

当你想在一个插槽中使用数据时，例如：

```html
<navigation-link url="/profile">
  Logged in as {{ user.name }}
</navigation-link>
```

该插槽跟模板的其它地方一样可以访问相同的实例 property (也就是相同的“作用域”)，而**不能**访问 `<navigation-link>` 的作用域。例如 `url` 是访问不到的：

```html
<navigation-link url="/profile">
  Clicking here will send you to: {{ url }}
  <!--
  这里的 `url` 会是 undefined，因为其 (指该插槽的) 内容是
  _传递给_ <navigation-link> 的而不是
  在 <navigation-link> 组件*内部*定义的。
  -->
</navigation-link>
```

**作为一条规则，请记住：**

> **父级模板里的所有内容都是在父级作用域中编译的；子模板里的所有内容都是在子作用域中编译的。**



实例：

vue实例中有msg.name值，而子组件中有age值。

以下只能拿到msg.name值，而不能拿到age值。所以父模板的所有内容是在父级作用域中编译，子模板的所有内容在子作用域中编译的。

```html
  <div id="app">
    <blog-post prop-c="hello!" >
      <div>
        <span>{{msg.name}}{{age}}</span>
        <span>2</span>
      </div>
    </blog-post>
  </div>
  <script>
    Vue.component('blog-post', {
      data (){
        return {
          age: 24
        }
      },
      template: `<div>
        <span>0</span>
        <slot>插槽接收自定义标签的内容</slot>
        </div>`
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



### 默认填充内容

插槽没有接收到内容时，显示插槽的默认内容

```html
<button type="submit">
  <slot>Submit</slot>
</button>
```



### 具名插槽

> `v-slot` 指令自 Vue 2.6.0 起被引入，提供更好的支持 `slot` 和 `slot-scope` attribute 的 API 替代方案。`v-slot` 完整的由来参见这份 [RFC](https://github.com/vuejs/rfcs/blob/master/active-rfcs/0001-new-slot-syntax.md)。在接下来所有的 2.x 版本中 `slot` 和 `slot-scope` attribute 仍会被支持，但已经被官方废弃且不会出现在 Vue 3 中。



让组件带有多个插槽，

`<slot>` 元素有一个特殊的 attribute：`name`。这个 attribute 可以用来定义额外的插槽：

**2.6.0之前的用法：**

```html
<div class="container">
    <slot name="header"></slot>

    <slot></slot>

    <slot name="footer"></slot>
</div>
```

一个不带 `name` 的 `<slot>` 出口会带有隐含的名字“default”。

插槽需要包裹多个同层级标签时，需要使用template标签来做外层标签

```html
  <named-slot>
    <template slot="header">
      <h1>Here might be a page title</h1>
    </template>

    <p>A paragraph for the main content.</p>

    <template slot="footer">
      <p>Here's some contact info</p>
    </template>
  </named-slot>
```

如果是一个有外层标签的话，可以直接`slot=""`在外层标签上：

```html
  <named-slot>
    <div slot="header">
      <p>1</p>
      <p>2</p>
    </div>

    <p>A paragraph for the main content.</p>

    <template slot="footer">
      <p>Here's some contact info</p>
    </template>
  </named-slot>
```

**2.6.0的用法：v-slot指令**

```html
<base-layout>
  <template v-slot:header>
    <h1>Here might be a page title</h1>
  </template>

  <template v-slot:default>
    <p>A paragraph for the main content.</p>
    <p>And another one.</p>
  </template>

  <template v-slot:footer>
    <p>Here's some contact info</p>
  </template>
</base-layout>
```



在向具名插槽提供内容的时候，我们可以在一个 `<template>` 元素上使用 `v-slot` 指令，并以 `v-slot` 的参数的形式提供其名称：

注意 **`v-slot` 只能添加在 `<template>` 上** (只有[一种例外情况](https://cn.vuejs.org/v2/guide/components-slots.html#独占默认插槽的缩写语法))，这一点和已经废弃的 [`slot` attribute](https://cn.vuejs.org/v2/guide/components-slots.html#废弃了的语法) 不同。

**例外情况是：独占默认插槽的缩写语法**

### 具名插槽缩写——2.6.0新增

> 2.6.0 新增

跟 `v-on` 和 `v-bind` 一样，`v-slot` 也有缩写，即把参数之前的所有内容 (`v-slot:`) 替换为字符 `#`。例如 `v-slot:header` 可以被重写为 `#header`：

```html
<base-layout>
  <template #header>
    <h1>Here might be a page title</h1>
  </template>

  <p>A paragraph for the main content.</p>
  <p>And another one.</p>

  <template #footer>
    <p>Here's some contact info</p>
  </template>
</base-layout>
```

然而，和其它指令一样，该缩写只在其有参数的时候才可用。这意味着以下语法是无效的：

```html
<!-- 这样会触发一个警告 -->
<current-user #="{ user }">
  {{ user.firstName }}
</current-user>
```

如果你希望使用缩写的话，你必须始终以明确插槽名取而代之：

```html
<current-user #default="{ user }">
  {{ user.firstName }}
</current-user>
```



### 作用域插槽

有时让插槽内容能够访问子组件中才有的数据是很有用的。**——插槽和插槽内容；——目的：插槽内容访问子组件的数据**

插槽通过v-bind:将属性值传递给父级插槽内容，父级插槽内容通过带值的 `v-slot` 来定义我们提供的插槽 prop 的名字：

注意v-slot:default是具名插槽的default名称写法。

```html
<current-user>
  <template v-slot:default="slotProps">
    {{ slotProps.user.firstName }}
  </template>
</current-user>
```

（在2.6之前通过slot-scope来接收插槽prop）

```html
<slot-example>
  <template slot="default" slot-scope="slotProps">
    {{ slotProps.msg }}
  </template>
</slot-example>
```

**独占默认插槽的写法**——**默认插槽的作用域插槽的缩写**

在上述情况下，当被提供的内容*只有*默认插槽时，组件的标签才可以被当作插槽的模板来使用。这样我们就可以把 `v-slot` 直接用在组件上：

```html
<current-user v-slot:default="slotProps">
  {{ slotProps.user.firstName }}
</current-user>
```

这种写法还可以更简单。就像假定未指明的内容对应默认插槽一样，不带参数的 `v-slot` 被假定对应默认插槽：

```html
<current-user v-slot="slotProps">
  {{ slotProps.user.firstName }}
</current-user>
```

注意默认插槽的缩写语法**不能**和具名插槽混用，因为它会导致作用域不明确：

只要出现多个插槽，请始终为*所有的*插槽使用完整的基于 `<template>` 的语法：

```html
<current-user>
  <template v-slot:default="slotProps">
    {{ slotProps.user.firstName }}
  </template>

  <template v-slot:other="otherSlotProps">
    ...
  </template>
</current-user>
```

**解构插槽Prop**

内部原理：因为插槽内容会被包裹在一个函数中，该函数接收 slotProps

```js
function (slotProps) {
  // 插槽内容
}
```

函数接收一个slotProps对象，意味着可以如下解构：**对象解构**

>  slotProps 与 { user }
>
> slotProps 与 { user: person }、
>
> slotProps 与 { user = { firstName: 'Guest' } }

所以，可以使用 [ES2015 解构](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/Destructuring_assignment#解构对象)来传入具体的插槽 prop，如下：

```html
<current-user v-slot="{ user }">
  {{ user.firstName }}
</current-user>
```

这样可以使模板更简洁，尤其是在该插槽提供了多个 prop 的时候。它同样开启了 prop 重命名等其它可能，例如将 `user` 重命名为 `person`：

```html
<current-user v-slot="{ user: person }">
  {{ person.firstName }}
</current-user>
```

你甚至可以定义后备内容，用于插槽 prop 是 undefined 的情形：

```html
<current-user v-slot="{ user = { firstName: 'Guest' } }">
  {{ user.firstName }}
</current-user>
```



### 动态插槽名——2.6.0新增

[动态指令参数](https://cn.vuejs.org/v2/guide/syntax.html#动态参数)也可以用在 `v-slot` 上，来定义动态的插槽名：

```html
<base-layout>
  <template v-slot:[dynamicSlotName]>
    ...
  </template>
</base-layout>
```

什么是动态指令参数呢？https://cn.vuejs.org/v2/guide/syntax.html#%E5%8A%A8%E6%80%81%E5%8F%82%E6%95%B0

#### 动态参数：

> 2.6.0 新增

从 2.6.0 开始，可以用方括号括起来的 JavaScript 表达式作为一个指令的参数：

```html
<!--
注意，参数表达式的写法存在一些约束，如之后的“对动态参数表达式的约束”章节所述。
-->
<a v-bind:[attributeName]="url"> ... </a>
```

这里的 `attributeName` 会被作为一个 JavaScript 表达式进行动态求值，求得的值将会作为最终的参数来使用。例如，如果你的 Vue 实例有一个 `data` property `attributeName`，其值为 `"href"`，那么这个绑定将等价于 `v-bind:href`。

同样地，你可以使用动态参数为一个动态的事件名绑定处理函数：

```html
<a v-on:[eventName]="doSomething"> ... </a>
```

在这个示例中，当 `eventName` 的值为 `"focus"` 时，`v-on:[eventName]` 将等价于 `v-on:focus`。

**对动态参数的值的约束**

动态参数预期会求出一个字符串，异常情况下值为 `null`。这个特殊的 `null` 值可以被显性地用于移除绑定。任何其它非字符串类型的值都将会触发一个警告。

**对动态参数表达式的约束**

动态参数表达式有一些语法约束，因为某些字符，如空格和引号，放在 HTML attribute 名里是无效的。例如：

```html
<!-- 这会触发一个编译警告 -->
<a v-bind:['foo' + bar]="value"> ... </a>
```

变通的办法是使用没有空格或引号的表达式，或用计算属性替代这种复杂表达式。

在 DOM 中使用模板时 (直接在一个 HTML 文件里撰写模板)，还需要避免使用大写字符来命名键名，因为浏览器会把 attribute 名全部强制转为小写：

```html
<!--
在 DOM 中使用模板时这段代码会被转换为 `v-bind:[someattr]`。
除非在实例中有一个名为“someattr”的 property，否则代码不会工作。
-->
<a v-bind:[someAttr]="value"> ... </a>
```

### 其它示例——不太明白

**插槽 prop 允许我们将插槽转换为可复用的模板，这些模板可以基于输入的 prop 渲染出不同的内容。**这在设计封装数据逻辑同时允许父级组件自定义部分布局的可复用组件时是最有用的。

例如，我们要实现一个 `<todo-list>` 组件，它是一个列表且包含布局和过滤逻辑：

```html
<ul>
  <li
    v-for="todo in filteredTodos"
    v-bind:key="todo.id"
  >
    {{ todo.text }}
  </li>
</ul>
```

我们可以将每个 todo 作为父级组件的插槽，以此通过父级组件对其进行控制，然后将 `todo` 作为一个插槽 prop 进行绑定：

```html
<ul>
  <li
    v-for="todo in filteredTodos"
    v-bind:key="todo.id"
  >
    <!--
    我们为每个 todo 准备了一个插槽，
    将 `todo` 对象作为一个插槽的 prop 传入。
    -->
    <slot name="todo" v-bind:todo="todo">
      <!-- 后备内容 -->
      {{ todo.text }}
    </slot>
  </li>
</ul>
```

现在当我们使用 `<todo-list>` 组件的时候，我们可以选择为 todo 定义一个不一样的 `<template>` 作为替代方案，并且可以从子组件获取数据：

```html
<todo-list v-bind:todos="todos">
  <template v-slot:todo="{ todo }">
    <span v-if="todo.isComplete">✓</span>
    {{ todo.text }}
  </template>
</todo-list>
```

这只是作用域插槽用武之地的冰山一角。想了解更多现实生活中的作用域插槽的用法，我们推荐浏览诸如 [Vue Virtual Scroller](https://github.com/Akryum/vue-virtual-scroller)、[Vue Promised](https://github.com/posva/vue-promised) 和 [Portal Vue](https://github.com/LinusBorg/portal-vue) 等库。

### 废弃的语法

地址：https://cn.vuejs.org/v2/guide/components-slots.html#%E5%BA%9F%E5%BC%83%E4%BA%86%E7%9A%84%E8%AF%AD%E6%B3%95

