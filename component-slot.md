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

