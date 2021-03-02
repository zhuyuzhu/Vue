# 数据data和方法methods

### 数据data

当一个 Vue 实例被创建时，它将 `data` 对象中的所有的 property 加入到 Vue 的**响应式系统**中。当这些 property 的值发生改变时，视图将会产生“响应”，即匹配更新为新的值。

MVVM模型中，数据模型model和视图view具有响应式，且其中一个发生改变，另一个也会通过ViewModel进行改变。比如：

```js
// 我们的数据对象
var data = { a: 1 }

// 该对象被加入到一个 Vue 实例中
var vm = new Vue({
  data: data
})

// 获得这个实例上的 property
// 返回源数据中对应的字段
vm.a == data.a // => true

// 设置 property 也会影响到原始数据
vm.a = 2
data.a // => 2

// ……反之亦然
data.a = 3
vm.a // => 3
```

当这些数据改变时，视图会进行重渲染。值得注意的是只有当实例被创建时就已经存在于 `data` 中的 property 才是**响应式**的。也就是说如果你添加一个新的 property，那么对该属性的改动将不会触发任何视图的更新。

```js
vm.b = 'hi'
```

这里唯一的例外是使用 `Object.freeze()`，这会阻止修改现有的 property，也意味着响应系统无法再*追踪*变化。

除了数据 property，Vue 实例还暴露了一些有用的实例 property 与方法。它们都有前缀 `$`，以便与用户定义的 property 区分开来。

#### 实例property

https://cn.vuejs.org/v2/api/#%E5%AE%9E%E4%BE%8B-property

**（1）vm.$el**

Vue 实例使用的根 DOM 元素。

**（2）vm.$data**

Vue 实例观察的数据对象。Vue 实例代理了对其 data 对象 property 的访问。

**vm.$props**

当前组件接收到的 props 对象。Vue 实例代理了对其 props 对象 property 的访问。

**vm.$options**

用于当前 Vue 实例的初始化选项。需要在选项中包含自定义 property 时会有用处：

```js
new Vue({
  customOption: 'foo',
  created: function () {
    console.log(this.$options.customOption) // => 'foo'
  }
})
```

**vm.$root**

当前组件树的根 Vue 实例。如果当前实例没有父实例，此实例将会是其自己。

**vm.$parent**

父实例，如果当前实例有的话。

**vm.$children**

当前实例的直接子组件。**需要注意 `$children` 并不保证顺序，也不是响应式的。**如果你发现自己正在尝试使用 `$children` 来进行数据绑定，考虑使用一个数组配合 `v-for` 来生成子组件，并且使用 Array 作为真正的来源。

**vm.$slots**



**vm.$scopedSlots**



**vm.$refs**

一个对象，持有注册过 [`ref` attribute](https://cn.vuejs.org/v2/api/#ref) 的所有 DOM 元素和组件实例。

**vm.$attrs**



**vm.$listeners**

包含了父作用域中的 (不含 `.native` 修饰器的) `v-on` 事件监听器。它可以通过 `v-on="$listeners"` 传入内部组件——在创建更高层次的组件时非常有用。

**vm.$isServer**

当前 Vue 实例是否运行于服务器。

#### object.freeze()

**`Object.freeze()`** 方法可以**冻结**一个对象。一个被冻结的对象再也不能被修改；冻结了一个对象则不能向这个对象添加新的属性，不能删除已有属性，不能修改该对象已有属性的可枚举性、可配置性、可写性，以及不能修改已有属性的值。此外，冻结一个对象后该对象的原型也不能被修改。

`freeze()` 返回和传入的参数相同的对象。

数据属性的值不可更改，访问器属性（有getter和setter）也同样（但由于是函数调用，给人的错觉是还是可以修改这个属性）。如果一个属性的值是个对象，则这个对象中的属性是可以修改的，除非它也是个冻结对象。数组作为一种对象，被冻结，其元素不能被修改。没有数组元素可以被添加或移除。

这个方法返回传递的对象，而不是创建一个被冻结的副本。



### 方法methods

（1）v-on监听事件

监听的事件处理函数，在methods对象中，处理函数的写法为`v-on:click="clickHandle()"`，如果不接收参数可以简写为`v-on:click="clickHandle"`



（2）普通方法调用，每次调用都重新执行，因为与计算属性的缓存有区别

