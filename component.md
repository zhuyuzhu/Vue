# 组件component

组件是可复用的 Vue 实例，且带有一个名字。因为组件是可复用的 Vue 实例，所以它们与 `new Vue` 接收相同的选项，例如 `data`、`computed`、`watch`、`methods` 以及生命周期钩子等。仅有的例外是像 `el` 这样根实例特有的选项。

### 创建组件

我们可以在一个通过 `new Vue` 创建的 Vue 根实例中，把这个组件`<button-counter>`作为自定义元素来使用：

vue实例化之前创建组件（使用组件前，要先创建组件）

```php+HTML
  <div id="components-demo">
    <button-counter></button-counter>
  </div>
  <script>
    // 定义一个名为 button-counter 的新组件
    Vue.component('button-counter', {
      data: function () {
        return {
          count: 0
        }
      },
      template: '<button v-on:click="count++">You clicked me {{ count }} times.</button>'
    })
    new Vue({
      el: '#components-demo'
    })

  </script>
```

### 复用组件

因为你每用一次组件，就会有一个它的新**实例**被创建。所以当点击按钮时，每个组件都会各自独立维护它的 `count`。

```html
<div id="components-demo">
  <button-counter></button-counter>
  <button-counter></button-counter>
  <button-counter></button-counter>
</div>
```

组件中的data是一个函数：

```js
data: function () {
  return {
    count: 0
  }
}
```

当我们定义这个 `<button-counter>` 组件时， `data` 并不是像Vue实例那样的一个对象，**一个组件的 `data` 选项必须是一个函数**，因此每个实例可以维护一份被返回对象的独立的拷贝。