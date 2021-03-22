# Vue学习笔记

### 学习资料

Vue官方文档：https://cn.vuejs.org/v2/guide/installation.html

菜鸟教程：https://www.runoob.com/vue2/vue-tutorial.html



### 基础知识——2021.2.24弄懂基础知识

**1、模板语法**

```html
<div id="app">
  {{ message }}
</div>
```

**2、指令**

https://m.php.cn/vuejs/464673.html

https://www.jianshu.com/p/c4a87e1b4ef7

Mustache 语法不能作用在 HTML attribute 上，遇到这种情况应该使用 [`v-bind` 指令](https://cn.vuejs.org/v2/api/#v-bind)：

```html
<div v-bind:id="dynamicId"></div>
```

对于布尔 attribute (它们只要存在就意味着值为 `true`)，`v-bind` 工作起来略有不同，在这个例子中：

```html
<button v-bind:disabled="isButtonDisabled">Button</button>
```

如果 `isButtonDisabled` 的值是 `null`、`undefined` 或 `false`，则 `disabled` attribute 甚至不会被包含在渲染出来的 `<button>` 元素中。



**支持表达式**

不管是在模板语法中，还是在指令中，都支持表达式

```js
{{ number + 1 }}

{{ ok ? 'YES' : 'NO' }}

{{ message.split('').reverse().join('') }}

<div v-bind:id="'list-' + id"></div>
```







**（1）v-text、v-html**

v-text修改元素标签的text文本，优先级高于模板语法

v-html 修改元素的innerhtml



**（2）v-if、v-else、v-else-if**

如果属性值为true，则显示。否则，不会渲染这个元素。

v-else是搭配v-if使用的，它必须紧跟在v-if或者v-else-if后面，否则不起作用。

**（3）v-show**

如果要非常频繁的切换，则使用v-show较好

https://cn.vuejs.org/v2/guide/conditional.html#v-if-vs-v-show

**（4）v-for、v-bind:key**



```html
    <ul v-for="(item, index) in nums" v-bind:key="item.id">
      <li>{{item.num}}</li>
    </ul>
```

```js
        nums: [{
          id: 1,
          num: 10
        },{
          id: 2,
          num: 20
        }]
```

https://blog.csdn.net/zyz00000000/article/details/83657831

问：v-for中为什么要加key

答：跟虚拟DOM的diff算法有关

**v-on**

监听事件

监听的事件处理函数，在methods对象中，处理函数的写法为`v-on:click="clickHandle()"`，如果不接收参数可以简写为`v-on:click="clickHandle"`

绑定多个事件的两种方式：

```html
<button v-on:mouseenter='onenter' v-on:mouseleave='leave'>click me</button>
<button v-on="{mouseenter:onenter,mouseleave:leave}">click me</button>
```

https://blog.csdn.net/zyz00000000/article/details/83753708



**v-bind:attribute**

相关文章：https://segmentfault.com/a/1190000022126326

- v-bind:title源码分析
- v-bind:class源码分析
- v-bind:style源码分析
- v-bind:text-content.prop源码分析
- v-bind的修饰符.camel .sync源码分析

v-bind:class

https://blog.csdn.net/zyz00000000/article/details/83651441

v-bind:style

https://blog.csdn.net/zyz00000000/article/details/83654579

v-bind:title

v-bind:href——a标签的href属性

v-bind:src——img标签的src属性

https://cn.vuejs.org/v2/guide/syntax.html#Attribute

```html
<button v-bind:disabled="isButtonDisabled">Button</button>
```



**v-pre** 

不进行编译，渲染出来是不经过vue处理的html结构

```html
<span v-text="text"  v-on:click="clickHandle" v-pre>{{message}}</span>
```

结果：渲染出来还是上面的原样内容。

v-pre主要用来跳过这个元素和它的子元素编译过程。可以用来显示原始的Mustache标签。跳过大量没有指令的节点加快编译。

**v-cloak**

这个指令是用来保持在元素上直到关联实例结束时进行编译

v-cloak指令防止页面未加载完成导致出现｛{name}}等变量



**v-model**

 表单输入和应用状态之间的双向绑定。

https://blog.csdn.net/zyz00000000/article/details/83786768



**v-once**

自定义指令：https://cn.vuejs.org/v2/guide/custom-directive.html

如果显示的信息后续不需要再修改，使用v-once，这样可以提高性能。

只渲染一次，后续改动数据也不会根据数据进行变动



### 计算属性

模板内的表达式非常便利，但是设计它们的初衷是用于简单运算的。在模板中放入太多的逻辑会让模板过重且难以维护。所以，对于任何复杂逻辑，你都应当使用**计算属性**





Vuex

Vuex 是专门为 Vue.js 设计的状态管理库，以利用 Vue.js 的细粒度数据响应机制来进行高效的状态更新。

https://vuex.vuejs.org/zh/









问题

官网上遇到的问题：

- 不同构建版本
- 完整版、编译器、运行时、UMD。。是什么？
- vue好像是用webpack构建的，webpack要大致了解一下



Vue的核心内容，大致明白其原理

Vue是响应式的，核心库只关注视图层，数据和 DOM建立联系。不再通过js来控制html元素，而是通过Vue来将数据和逻辑挂载到DOM元素上，对其进行完全控制。

#### Vue的响应式

当一个 Vue 实例被创建时，它将 `data` 对象中的所有的 property 加入到 Vue 的**响应式系统**中。当这些 property 的值发生改变时，视图将会产生“响应”，即匹配更新为新的值。

只有Vue被创建时的data中的数据才会添加到响应式系统中，所以后续添加到Vue实例对象上的变量是不具有响应式的。

可以使用 `Object.freeze()`，这会阻止修改现有的 property，也意味着响应系统无法再*追踪*变化。

了解object.freeze() ：https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Object/freeze



指令 (Directives) 是带有 `v-` 前缀的特殊 attribute。指令 attribute 的值预期是**单个 JavaScript 表达式** (`v-for` 是例外情况，稍后我们再讨论)。指令的职责是，当表达式的值改变时，将其产生的连带影响，响应式地作用于 DOM。

实例：

```html
<p v-if="seen">现在你看到我了</p>
```

这里，`v-if` 指令将根据表达式 `seen` 的值的真假来插入/移除 `<p>` 元素。



**动态绑定指令**

当 `eventName` 的值为 `"focus"` 时，`v-on:[eventName]` 将等价于 `v-on:focus`。

如果你的 Vue 实例有一个 `data` property `attributeName`，其值为 `"href"`，那么这个绑定将等价于 `v-bind:href`。

```html
<a v-bind:[attributeName]="url"> ... </a>

<a v-on:[eventName]="doSomething"> ... </a>
```

动态指令参数预期会求出一个字符串，异常情况下值为 `null`。这个特殊的 `null` 值可以被显性地用于移除绑定。任何其它非字符串类型的值都将会触发一个警告。

不合法的警告：

```html
<!-- 这会触发一个编译警告 -->
<a v-bind:['foo' + bar]="value"> ... </a>
```



#### 需要了解new Vue () 返回的对象是什么

除了数据 property，Vue 实例还暴露了一些有用的实例 property 与方法。它们都有前缀 `$`，以便与用户定义的 property 区分开来。



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



MVVM和MVC模型

MVVM是Model-View-ViewModel的简写。它本质上就是MVC 的改进版。MVVM 就是将其中的View 的状态和行为抽象化，让我们将视图 UI 和业务逻辑分开。当然这些事 ViewModel 已经帮我们做了，它可以取出 Model 的数据同时帮忙处理 View 中由于需要展示内容而涉及的业务逻辑。

https://baijiahao.baidu.com/s?id=1596277899370862119&wfr=spider&for=pc

**Mvvm定义**MVVM是Model-View-ViewModel的简写。即模型-视图-视图模型。【模型】指的是后端传递的数据。【视图】指的是所看到的页面。【视图模型】mvvm模式的核心，它是连接view和model的桥梁。它有两个方向：一是将【模型】转化成【视图】，即将后端传递的数据转化成所看到的页面。实现的方式是：数据绑定。二是将【视图】转化成【模型】，即将所看到的页面转化成后端的数据。实现的方式是：DOM 事件监听。这两个方向都实现的，我们称之为数据的双向绑定。总结：在MVVM的框架下视图和模型是不能直接通信的。它们通过ViewModel来通信，ViewModel通常要实现一个observer观察者，当数据发生变化，ViewModel能够监听到数据的这种变化，然后通知到对应的视图做自动更新，而当用户操作视图，ViewModel也能监听到视图的变化，然后通知数据做改动，这实际上就实现了数据的双向绑定。并且MVVM中的View 和 ViewModel可以互相通信。

MVC是Model-View- Controller的简写。即模型-视图-控制器

MVC：MVC 的处理流程是 V -> C -> M -> C -> V。

验证账号密码：可以理解为视图层V输入数据——到C进行数据处理——到M进行存储——到C知道验证成功——V提示验证成功



做开发三四年了，前段、后端和IOS客户端都有过一些开发经验，而且也经常和团队里的其他成员交流开发心得。综合来看，大家对MVC的模型、视图、控制器的概念都是一致的，只是由于在前后端和客户端不同的开发场景下，有不同的侧重点而已。
比如前端主要是页面展示和用户交互，因此MVC中重点在视图V，有些场景下承担业务逻辑和交互的控制器C与视图V完全放在了一起，而模型M即与服务端交互的接口及浏览器本地的存储操作则作为单独的一部分；后端开发就会有很大不同，尤其是只提供接口时，MVC中就会更侧重模型M，视图V概念则弱化为了对外开放的接口具体到实现上甚至就是一系列的接口列表，而控制器C则承担接口的实现及部分服务端操作如定时任务等功能，成为较厚重的一层，模型M承担数据库操作和从其他服务获取数据的功能则作为第三层；客户端的MVC则一般都较为均衡，但是界面展示与业务逻辑很多时候还是会强绑定，造成V与C结合在一起，例如纯代码开发IOS时，每个页面的展示及交互逻辑分层很明显，但是就整个项目来说，视图V并没有形成单独的一层，是成为了控制器C层的一部分。
因而，MVC也好，MVP也好，MVVM也好，重要的是针对应用场景和需求对M、V、C三层进行划分，三层间的交互也是如此。只要确定了架构后遵循一定的原则，在开发过程中尽量不破坏原有规则，直到现有的架构规则不能满足需求，再重新制定。这样应该就能在满足应用场景需求的同时，使得项目有明确清晰的层次。在比较框架的定义和优劣时，也要有一定的场景说明才有实际意义。
回到阮老师的总结，个人感觉他是从广义上对这些框架进行讲解的，我们在理解时，应该根据不同项目的实际情况进行参照。大家在评论的时候最好说明是在什么样的场景下框架的使用，这样也方便不同开发背景的同学学习。



设计模式

观察者模式、状态模式、

https://www.runoob.com/design-pattern/design-pattern-tutorial.html

**单一职责原则**（SRP：Single responsibility principle）又称单一功能原则，面向对象五个基本原则（SOLID）之一。



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



