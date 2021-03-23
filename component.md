# 组件component

组件是可复用的 Vue 实例，且带有一个名字。因为组件是可复用的 Vue 实例，所以它们与 `new Vue` 接收相同的选项，例如 `data`、`computed`、`watch`、`methods` 以及生命周期钩子等。仅有的例外是像 `el` 这样根实例特有的选项。

**一个组件的 `data` 选项必须是一个函数**，因此每个实例可以维护一份被返回对象的独立的拷贝

组件名：

强烈推荐遵循 [W3C 规范](https://html.spec.whatwg.org/multipage/custom-elements.html#valid-custom-element-name)中的自定义组件名 (字母全小写且必须包含一个连字符)。这会帮助你避免和当前以及未来的 HTML 元素相冲突。

https://html.spec.whatwg.org/multipage/custom-elements.html#valid-custom-element-name

 kebab-case（短横线隔开）  和 PascalCase（帕斯卡命名法，首字母大写命名）



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



### 组件注册——全局组件和局部组件

为了能在模板中使用，这些组件必须先注册以便 Vue 能够识别。这里有两种组件的注册类型：**全局注册**和**局部注册**。

##### 全局组件

至此，我们的组件都只是通过 `Vue.component` 全局注册的：

```js
Vue.component('my-component-name', {
  // ... options ...
})
```

全局注册的组件可以用在其被注册之后的任何 (通过 `new Vue`) 新创建的 Vue 根实例，也包括其组件树中的所有子组件的模板中。

##### 局部组件

全局注册往往是不够理想的。比如，如果你使用一个像 webpack 这样的构建系统，全局注册所有的组件意味着即便你已经不再使用一个组件了，它仍然会被包含在你最终的构建结果中。这造成了用户下载的 JavaScript 的无谓的增加。**——？？？**

通过一个普通的 JavaScript 对象来定义组件：**——局部组件是一个js对象**

```js
var ComponentA = { /* ... */ }
var ComponentB = { /* ... */ }
var ComponentC = { /* ... */ }
```

然后在 `components` 选项中定义你想要使用的组件：**——局部组件的使用，需要在components中定义**

```js
new Vue({
  el: '#app',
  components: {
    'component-a': ComponentA,
    'component-b': ComponentB
  }
})
```

**示例：**

```html
  <div id="app">
    <component-a></component-a>
    <component-b></component-b>
  </div>
  <script>
    var ComponentA = {
      data() {
        return {
          text: "局部组件A"
        }
      },
      template: `<span>{{text}}</span>`
    }
    var ComponentB = {
      data() {
        return {
          text: "局部组件B"
        }
      },
      template: `<span>{{text}}</span>`
    }
    new Vue({
      el: '#app',
      components: {
        'component-a': ComponentA,
        'component-b': ComponentB
      }
    })
  </script>
```

如果你希望 `ComponentA` 在 `ComponentB` 中可用，则你需要这样写：

```html
  <div id="app">
    <component-b></component-b>
  </div>
  <script>
    var ComponentA = {
      data() {
        return {
          text: "局部组件A"
        }
      },
      template: `<span>{{text}}</span>`
     
    }
    var ComponentB = {
      data() {
        return {
          text: "局部组件B"
        }
      },
      
      components: {
        'component-a': ComponentA
      },
      template: ` <component-a></component-a>`
    }
    new Vue({
      el: '#app',
      components: {
        'component-b': ComponentB
      }
    })
  </script>
```

#### 模块系统中的全局组件和局部组件



**局部组件**

我们推荐创建一个 `components` 目录，并将每个组件放置在其各自的文件中。

然后你需要在局部注册之前导入每个你想使用的组件。例如，在一个假设的 `ComponentB.js` 或 `ComponentB.vue` 文件中：

```js
import ComponentA from './ComponentA'
import ComponentC from './ComponentC'

export default {
  components: {
    ComponentA,
    ComponentC
  },
  // ...
}
```

现在 `ComponentA` 和 `ComponentC` 都可以在 `ComponentB` 的模板中使用了。



**基础组件的自动化全局注册**

可能你的许多组件只是包裹了一个输入框或按钮之类的元素，是相对通用的。我们有时候会把它们称为[基础组件](https://cn.vuejs.org/v2/style-guide/#基础组件名-强烈推荐)，它们会在各个组件中被频繁的用到。

所以会导致很多组件里都会有一个包含基础组件的长列表：

```js
import BaseButton from './BaseButton.vue'
import BaseIcon from './BaseIcon.vue'
import BaseInput from './BaseInput.vue'

export default {
  components: {
    BaseButton,
    BaseIcon,
    BaseInput
  }
}
```

而只是用于模板中的一小部分：

```html
<BaseInput
  v-model="searchText"
  @keydown.enter="search"
/>
<BaseButton @click="search">
  <BaseIcon name="search"/>
</BaseButton>
```

以上遇到的问题，我们可以通过webpack的`require.context`来全局注册这些非常通用的基础组件**——webpack来全局注册通用的基础组件**



这里有一份可以让你在应用入口文件 (比如 `src/main.js`) 中全局导入基础组件的示例代码：**——应用入口**

Lodash 通过降低 array、number、objects、string 等等的使用难度从而让 JavaScript 变得更简单

```js
import Vue from 'vue'
import upperFirst from 'lodash/upperFirst'
import camelCase from 'lodash/camelCase'

const requireComponent = require.context(
  // 其组件目录的相对路径
  './components',
  // 是否查询其子目录
  false,
  // 匹配基础组件文件名的正则表达式
  /Base[A-Z]\w+\.(vue|js)$/
)

requireComponent.keys().forEach(fileName => {
  // 获取组件配置
  const componentConfig = requireComponent(fileName)

  // 获取组件的 PascalCase 命名
  const componentName = upperFirst(
    camelCase(
      // 获取和目录深度无关的文件名
      fileName
        .split('/')
        .pop()
        .replace(/\.\w+$/, '')
    )
  )

  // 全局注册组件
  Vue.component(
    componentName,
    // 如果这个组件选项是通过 `export default` 导出的，
    // 那么就会优先使用 `.default`，
    // 否则回退到使用模块的根。
    componentConfig.default || componentConfig
  )
})
```

记住**全局注册的行为必须在根 Vue 实例 (通过 `new Vue`) 创建之前发生**。[这里](https://github.com/chrisvfritz/vue-enterprise-boilerplate/blob/master/src/components/_globals.js)有一个真实项目情景下的示例。

