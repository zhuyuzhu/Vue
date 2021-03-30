# 过滤器 filters

Vue.js 允许你自定义过滤器，可被用于一些常见的文本格式化。——常用于文本格式化

过滤器可以用在两个地方：**双花括号插值和 `v-bind` 表达式** (后者从 2.1.0+ 开始支持)。过滤器应该被添加在 JavaScript 表达式的尾部，由“管道”符号指示：——什么是管道符号？？？

```html
<!-- 在双花括号中 -->
{{ message | capitalize }}

<!-- 在 `v-bind` 中 -->
<div v-bind:id="rawId | formatId"></div>
```

你可以在一个组件的选项中定义本地的过滤器：

```js
filters: {
  capitalize: function (value) {
    if (!value) return ''
    value = value.toString()
    return value.charAt(0).toUpperCase() + value.slice(1)
  }
}
```

实例：

```html
  <div id="app">
    <filter-demo></filter-demo>
  </div>
<script>
    Vue.component('filter-demo', {
      data(){
        return {
          url: 'www.baidu.com',
          urlName: '百度一下'
        }
      },
      template: `<a v-bind:href="url | githubUrl">{{urlName|github}}</a>`,
      filters: {
        github(value){//接收值
          console.log(value); //urlName的值
          return 'GitHub官网'
        },
        githubUrl(value){
          console.log(value); //url的值
          return 'github.com'
        }
      }
    })
    var vm = new Vue({
      el: '#app',
      myOption: 'hello',
      data: {
        
      }
    })
</script>
```





或者在创建 Vue 实例之前全局定义过滤器：——使用到该过滤器的地方，值都会被处理。

```js
Vue.filter('capitalize', function (value) {
  if (!value) return ''
  value = value.toString()
  return value.charAt(0).toUpperCase() + value.slice(1)
})

new Vue({
  // ...
})
```

当全局过滤器和局部过滤器重名时，会采用局部过滤器。



#### 关于过滤器的参数：

过滤器函数总接收表达式的值 (之前的操作链的结果) 作为第一个参数。在上述例子中，`capitalize` 过滤器函数将会收到 `message` 的值作为第一个参数。

过滤器可以串联：

```js
{{ message | filterA | filterB }}
```

在这个例子中，`filterA` 被定义为接收单个参数的过滤器函数，表达式 `message` 的值将作为参数传入到函数中。然后继续调用同样被定义为接收单个参数的过滤器函数 `filterB`，将 `filterA` 的结果传递到 `filterB` 中。

过滤器是 JavaScript 函数，因此可以接收参数：

```js
{{ message | filterA('arg1', arg2) }}
```

这里，`filterA` 被定义为接收三个参数的过滤器函数。其中 `message` 的值作为第一个参数，普通字符串 `'arg1'` 作为第二个参数，表达式 `arg2` 的值作为第三个参数。

