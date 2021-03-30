# 渲染函数  render

需求：根据组件元素传入的值，组件的template模板（可以由script提供指定id的template）提供不同的标签内容

比如：——知识点：template模块、组件template内容的v-if的使用

```html
  <script type="text/x-template" id="anchored-heading-template">
    <h1 v-if="level === 1">
      <slot></slot>
    </h1>
    <h2 v-else-if="level === 2">
      <slot></slot>
    </h2>
    <h3 v-else-if="level === 3">
      <slot></slot>
    </h3>
    <h4 v-else-if="level === 4">
      <slot></slot>
    </h4>
    <h5 v-else-if="level === 5">
      <slot></slot>
    </h5>
    <h6 v-else-if="level === 6">
      <slot></slot>
    </h6>
  </script>


  <div id="app">
    <anchored-heading :level="4">Hello world!</anchored-heading>
  </div>

  <script>
    Vue.component('anchored-heading', {
      template: '#anchored-heading-template',
      props: {
        level: {
          type: Number,
          required: true
        }
      }
    })
    var vm = new Vue({
      el: '#app',
      data: {

      }
    })
  </script>
```

如果使用render函数，来代替template，如下：**需要非常熟悉 Vue 的实例 property。**

```html
  <div id="app">
    <anchored-heading :level="1">Hello world!</anchored-heading>
  </div>

  <script>
    Vue.component('anchored-heading', {
      render: function (createElement) {//默认接收参数createElement，像事件处理函数的event或e
        return createElement(
          'h' + this.level, // 标签名称
          this.$slots.default // 子节点数组
        )
      },
      props: {
        level: {
          type: Number,
          required: true
        }
      }
    })
    var vm = new Vue({
      el: '#app',
      data: {

      }
    })
  </script>
```

在这个例子中，你需要知道，向组件中传递不带 `v-slot` 指令的子节点时，比如 `anchored-heading` 中的 `Hello world!`，这些子节点被存储在组件实例中的 `$slots.default` 中。如果你还不了解，**在深入渲染函数之前推荐阅读[实例 property API](https://cn.vuejs.org/v2/api/#实例-property)。**

render函数中createElement的用法：



this.$slots.default是什么？——？？？标签组件内容的子节点。

向组件中传递不带 `v-slot` 指令的子节点时，比如 `anchored-heading` 中的 `Hello world!`，这些子节点被存储在组件实例中的 `$slots.default` 中。

实例：

```html
  <div id="app">
    <anchored-heading elem="div">
      <span>1111</span>
      <span>2222</span>
    </anchored-heading>
  </div>

  <script>
    Vue.component('anchored-heading', {
      render: function (createElement) {//默认接收参数createElement，像事件处理函数的event或e
        console.log(this.$slots.default); //数组，对应标签内容的子标签。包括文本（回车、空格 ）、元素。
        return createElement(
          this.elem, // 标签名称
          this.$slots.default // 子节点数组
        )
      },
      props: {
        elem: {
          type: String,
          required: true
        }
      }
    })
    var vm = new Vue({
      el: '#app',
      data: {

      }
    })
  </script>
```

打印结果：

> 1. 0: VNode {tag: "span", data: undefined, children: Array(1), text: undefined, elm: span, …}
> 2. 1: VNode {tag: undefined, data: undefined, children: undefined, text: " ", elm: text, …}
> 3. 2: VNode {tag: "span", data: undefined, children: Array(1), text: undefined, elm: span, …}
> 4. length: 3
> 5. __proto__: Array(0)



### `createElement` 参数

如何使用createElement来实现组件template中的功能，了解createElement的参数及使用：

```js
// @returns {VNode}
createElement(
  // {String | Object | Function}
  // 一个 HTML 标签名、组件选项对象，或者
  // resolve 了上述任何一种的一个 async 函数。必填项。
  'div',

  // {Object}
  // 一个与模板中 attribute 对应的数据对象。可选。
  {
    // (详情见下一节)
  },

  // {String | Array}
  // 子级虚拟节点 (VNodes)，由 `createElement()` 构建而成，
  // 也可以使用字符串来生成“文本虚拟节点”。可选。
  [
    '先写一些文字',
    createElement('h1', '一则头条'),
    createElement(MyComponent, {
      props: {
        someProp: 'foobar'
      }
    })
  ]
)
```

第一个参数：String类型



要对Vue组件整体掌握后，才容易理解这里。。。