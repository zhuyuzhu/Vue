# 组件插槽component Slots



https://cn.vuejs.org/v2/guide/components-slots.html



> 在 2.6.0 中，我们为具名插槽和作用域插槽引入了一个新的统一的语法 (即 `v-slot` 指令)。它取代了 `slot` 和 `slot-scope` 这两个目前已被废弃但未被移除且仍在[文档中](https://cn.vuejs.org/v2/guide/components-slots.html#废弃了的语法)的 attribute。新语法的由来可查阅这份 [RFC](https://github.com/vuejs/rfcs/blob/master/active-rfcs/0001-new-slot-syntax.md)。

### 插槽内容

Vue 实现了一套内容分发的 API，这套 API 的设计灵感源自 [Web Components 规范草案](https://github.com/w3c/webcomponents/blob/gh-pages/proposals/Slots-Proposal.md)，将 `<slot>` 元素作为承载分发内容的出口。



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

让组件带有多个插槽，

`<slot>` 元素有一个特殊的 attribute：`name`。这个 attribute 可以用来定义额外的插槽：

```html
<div class="container">
  <header>
    <slot name="header"></slot>
  </header>
  <main>
    <slot></slot>
  </main>
  <footer>
    <slot name="footer"></slot>
  </footer>
</div>
```

在向具名插槽提供内容的时候，我们可以在一个 `<template>` 元素上使用 `v-slot` 指令，并以 `v-slot` 的参数的形式提供其名称：

注意 **`v-slot` 只能添加在 `<template>` 上** (只有[一种例外情况](https://cn.vuejs.org/v2/guide/components-slots.html#独占默认插槽的缩写语法))，这一点和已经废弃的 [`slot` attribute](https://cn.vuejs.org/v2/guide/components-slots.html#废弃了的语法) 不同。



### 作用域插槽

有时让插槽内容能够访问子组件中才有的数据是很有用的。**——插槽和插槽内容；插槽内容访问子组件的数据**

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

独占默认插槽的写法

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



### 解构插槽Prop

内部原理：因为插槽内容会被包裹在一个函数中，该函数接收 slotProps

```js
function (slotProps) {
  // 插槽内容
}
```

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

### 具名插槽缩写——2.6.0新增



### 废弃的语法

地址：https://cn.vuejs.org/v2/guide/components-slots.html#%E5%BA%9F%E5%BC%83%E4%BA%86%E7%9A%84%E8%AF%AD%E6%B3%95

