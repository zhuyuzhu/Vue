# Vue学习笔记

### 学习资料

Vue官方文档：https://cn.vuejs.org/v2/guide/installation.html

菜鸟教程：https://www.runoob.com/vue2/vue-tutorial.html



Vuex

https://vuex.vuejs.org/zh/



v-bind

相关文章：https://segmentfault.com/a/1190000022126326

- v-bind:key源码分析
- v-bind:title源码分析
- v-bind:class源码分析
- v-bind:style源码分析
- v-bind:text-content.prop源码分析
- v-bind的修饰符.camel .sync源码分析



v-on



问题

官网上遇到的问题：

- 不同构建版本
- 完整版、编译器、运行时、UMD。。是什么？
- vue好像是用webpack构建的，webpack要大致了解一下



Vue的核心内容，大致明白其原理

Vue是响应式的，核心库只关注视图层，数据和 DOM建立联系。不再通过js来控制html元素，而是通过Vue来将数据和逻辑挂载到DOM元素上，对其进行完全控制。

如下：

（1）html文本展示——模板语法

（2）v-bind

- v-bind:title="message"
- v-bind:class和v-bind:style
- 

（3）v-if和v-show的区别

等等。。。



需要了解new Vue () 返回的对象是什么



虚拟DOM的Diff算法



v-for 结合 v-bind:key 的好处：https://cn.vuejs.org/v2/guide/list.html#%E7%BB%B4%E6%8A%A4%E7%8A%B6%E6%80%81



哪些指令或规则是从data对象取值；哪些是从methods对象中取方法



```html
  <div id="app" v-bind:title="date">
    <span>{{ message }}</span>
    <span v-if="isShow">v-if显示</span>
    <span v-show="!isShow">v-show显示</span>
  </div>
```



指令：

v-on

监听 DOM 事件



v-once

https://cn.vuejs.org/v2/api/#v-once



v-model

https://cn.vuejs.org/v2/guide/forms.html#%E5%9F%BA%E7%A1%80%E7%94%A8%E6%B3%95



Vue组件

https://cn.vuejs.org/v2/guide/forms.html#%E5%9F%BA%E7%A1%80%E7%94%A8%E6%B3%95



MVVM和MVM模型





生命周期和钩子函数

https://cn.vuejs.org/v2/guide/instance.html#%E7%94%9F%E5%91%BD%E5%91%A8%E6%9C%9F%E5%9B%BE%E7%A4%BA

https://segmentfault.com/a/1190000011381906

https://segmentfault.com/a/1190000008010666





响应式：

存在于data对象中的数据，才具有响应式

https://cn.vuejs.org/v2/guide/instance.html#%E6%95%B0%E6%8D%AE%E4%B8%8E%E6%96%B9%E6%B3%95



JSX 语法



计算属性和监听属性

https://cn.vuejs.org/v2/guide/computed.html#%E8%AE%A1%E7%AE%97%E5%B1%9E%E6%80%A7-vs-%E4%BE%A6%E5%90%AC%E5%B1%9E%E6%80%A7



什么是虚拟DOM？——diff方法

https://www.jianshu.com/p/af0b398602bc

https://segmentfault.com/a/1190000016647776

https://www.zhihu.com/question/29504639

https://www.cnblogs.com/gaosong-shuhong/p/9253959.html

http://www.mamicode.com/info-detail-3059000.html

