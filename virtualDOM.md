# 虚拟DOM

https://segmentfault.com/a/1190000008291645

https://github.com/DDFE/DDFE-blog/issues/18

https://www.jianshu.com/p/4dbb3712ced7

https://www.jianshu.com/p/af0b398602bc



地址：https://cn.vuejs.org/v2/guide/render-function.html#%E8%99%9A%E6%8B%9F-DOM

Vue 通过建立一个**虚拟 DOM** 来追踪自己要如何改变真实 DOM。

```js
return createElement('h1', this.blogTitle)
```

**`createElement` 到底会返回什么呢？**

其实不是一个*实际的* DOM 元素。它更准确的名字可能是 `createNodeDescription`，因为它所包含的信息会告诉 Vue 页面上需要渲染什么样的节点，包括及其子节点的描述信息。我们把这样的节点描述为“虚拟节点 (virtual node)”，也常简写它为“**VNode**”。“虚拟 DOM”是我们对由 Vue 组件树建立起来的整个 VNode 树的称呼。

