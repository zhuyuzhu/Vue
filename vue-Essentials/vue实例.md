# vue instance （vue实例）

vue实例上有什么，vue实例的属性和方法有什么用处？——组件也是Vue实例。

数据 property

实例 property——它们都有前缀 `$`，以便与用户定义的 property 区分开来

方法

实例方法、实例属性、实例事件

https://cn.vuejs.org/v2/api/#%E5%AE%9E%E4%BE%8B-property



### 实例属性

$data

Vue 实例观察的数据对象。Vue 实例代理了对其 data 对象 property 的访问。

```js
    const vm = new Vue({
      data: {
        message: '111'
      },
      router
    }).$mount('#app')

    console.log(vm.message === vm.$data.message); //true
```



vm.$el

Vue 实例使用的根 DOM 元素。



vm.$options

用于当前 Vue 实例的初始化选项。需要在选项中包含自定义 property 时会有用处：

```js
new Vue({
  customOption: 'foo',
  created: function () {
    console.log(this.$options.customOption) // => 'foo'
  }
}
```

默认有哪些属性和方法呢？

创建之前的钩子函数和销毁之后的钩子函数：beforeCreate、destroyed

组件、过滤器、指令对象：components、filters、directives

渲染函数：render

如果定义了其他属性或者方法，也会挂载在$options上



vm.$root

vue状态管理使用vuex,如果项目不大，逻辑不多，name我们没必要用vuex给项目增加难度，只需要用$root设置vue实例的data就行了，

在组件中，可以直接通过`this.$root`获取vm实例



vm.$parent

子组件通过$parent属性获取父组件实例，访问父组件的属性和方法

`this.$parent`



### 实例方法

地址：https://cn.vuejs.org/v2/api/#%E5%AE%9E%E4%BE%8B%E6%96%B9%E6%B3%95-%E6%95%B0%E6%8D%AE

vm.$watch( expOrFn, callback, [options] )



vm.$set( target, propertyName/index, value )



vm.$delete( target, propertyName/index )





### 实例事件