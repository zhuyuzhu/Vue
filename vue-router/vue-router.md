# vue-router入门
### 安装Installation

#### 直接下载或者使用CDN连接 Direct Download/CDN

Unpkg.com 提供了基于 NPM 的 CDN 链接。使用地址：https://unpkg.com/vue-router/dist/vue-router.js。上面的链接会一直指向在 NPM 发布的最新版本。你也可以像 https://unpkg.com/vue-router@2.0.0/dist/vue-router.js 这样指定 版本号 或者 Tag。


```html
<script src="/path/to/vue.js"></script>
<script src="/path/to/vue-router.js"></script>
```

#### NPM
```sh
npm install vue-router
```
如果在一个模块化工程中使用它，必须要通过 Vue.use() 明确地安装路由功能：
```js
import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)
```

#### Vue-CLI

通过Vue-CLI构建项目时，可以以插件的形式添加Vue Router，CLI 可以生成上述代码及两个示例路由。它也会覆盖你的 `App.vue`，因此请确保在项目中运行以下命令之前备份之前的`App.vue`文件：
```sh
vue add router
```

#### 构建开发版
如果你想使用最新的开发版，就得从 GitHub 上直接 clone，然后自己 build 一个 `vue-router`。

```sh
git clone https://github.com/vuejs/vue-router.git node_modules/vue-router
cd node_modules/vue-router
npm install
npm run build
```

### 基础 Essential

#### 起步 Getting Started

用 Vue.js + Vue Router 创建单页应用，通过Vue Router 将Vue组件 (components) 映射到路由 (routes)，这样Vue Router知道在哪里渲染这些组件。

示例：

- 使用 router-link 组件来导航，通过传入 `to` 属性指定链接，`<router-link>` 默认会被渲染成一个 `<a>` 标签
- `<router-view>`路由出口，路由匹配到的组件将渲染在这里
- 如果使用模块化机制编程，导入Vue和VueRouter，要调用 Vue.use(VueRouter)

```html
  <div id="app">
    <h1>Hello App!</h1>
    <p>
      <!-- 使用 router-link 组件来导航. -->
      <!-- 通过传入 `to` 属性指定链接. -->
      <!-- <router-link> 默认会被渲染成一个 `<a>` 标签 -->
      <router-link to="/foo">Go to Foo</router-link>
      <router-link to="/bar">Go to Bar</router-link>
    </p>
    <!-- 路由出口 -->
    <!-- 路由匹配到的组件将渲染在这里 -->
    <router-view></router-view>
  </div>

  <script>
    // 0. 如果使用模块化机制编程，导入Vue和VueRouter，要调用 Vue.use(VueRouter)

    // 1. 定义 (路由) 组件。
    // 可以从其他文件 import 进来
    const Foo = {
      template: '<div>foo</div>'
    }
    const Bar = {
      template: '<div>bar</div>'
    }

    // 2. 定义路由
    // 每个路由应该映射一个组件。 其中"component" 可以是
    // 通过 Vue.extend() 创建的组件构造器，
    // 或者，只是一个组件配置对象。
    // 我们晚点再讨论嵌套路由。
    const routes = [{
        path: '/foo',
        component: Foo
      },
      {
        path: '/bar',
        component: Bar
      }
    ]

    // 3. 创建 router 实例，然后传 `routes` 配置
    // 你还可以传别的配置参数, 不过先这么简单着吧。
    const router = new VueRouter({
      routes // (缩写) 相当于 routes: routes
    })

    // 4. 创建和挂载根实例。
    // 记得要通过 router 配置参数注入路由，
    // 从而让整个应用都有路由功能
    const app = new Vue({
      router
    }).$mount('#app')

    // 现在，应用已经启动了！
  </script>
```



通过注入路由器，我们可以在任何组件内通过 `this.$router` 访问路由器，也可以通过 `this.$route` 访问当前路由：

```js
// Home.vue
export default {
  computed: {
    username() {
      // 我们很快就会看到 `params` 是什么
      return this.$route.params.username
    }
  },
  methods: {
    goBack() {
      window.history.length > 1 ? this.$router.go(-1) : this.$router.push('/')
    }
  }
}
```

该文档通篇都常使用 `router` 实例。留意一下 `this.$router` 和 `router` 使用起来完全一样。我们使用 `this.$router` 的原因是我们并不想在每个独立需要封装路由的组件中都导入路由。

要注意，当 `<router-link>` 对应的路由匹配成功，将自动设置 class 属性值 `.router-link-active`。



#### 动态路由——“动态路径参数”(dynamic segment)

可以获取路径的动态值，比如detail/1和 detail/2

```js
const User = {
  template: '<div>User</div>'
}

const router = new VueRouter({
  routes: [
    // 动态路径参数 以冒号开头
    { path: '/user/:id', component: User }
  ]
})
```

一个“路径参数”使用冒号 `:` 标记，当匹配到一个路由时，参数值会被设置到 `this.$route.params`，可以在每个组件内使用。

`path: '/user/:id'`意味着接收的路径/user/后面有个 动态值，像 `/user/foo` 和 `/user/bar` 都将映射到相同的路由。

示例：

**注意：to属性的路径，`/user/foo`代表hash根路径，会被解析为 ：`<a href="#/user/foo" class="">Go to Foo</a>`**

**`user/foo`当前路径下跳转到该路径（路径拼接，在user后面拼接user/bar，每次点击，都会额外添加一个user）**

**根据to的路径，匹配路由path**

```html
  <div id="app">
    <p>
      <router-link to="/user/foo">Go to Foo</router-link>
      <router-link to="/user/bar">Go to Bar</router-link>
    </p>
    <router-view></router-view>
  </div>

  <script>
    const User = {
      template: '<div>User {{$route.params.id}}</div>',
    }
    const routes = [{
        path: '/user/:id',//匹配路径user/动态值
        component: User
      }
    ]
    const router = new VueRouter({
      routes
    })

    const app = new Vue({
      router
    }).$mount('#app')
  </script>
```



你可以在一个路由中设置多段“路径参数”，对应的值都会设置到 `$route.params` 中。例如：

| 模式                          | 匹配路径            | $route.params                          |
| ----------------------------- | ------------------- | -------------------------------------- |
| /user/:username               | /user/evan          | `{ username: 'evan' }`                 |
| /user/:username/post/:post_id | /user/evan/post/123 | `{ username: 'evan', post_id: '123' }` |

除了 `$route.params` 外，`$route` 对象还提供了其它有用的信息，例如，`$route.query` (如果 URL 中有查询参数)、`$route.hash` 等等

可以通过路由对象来查看相关的属性，地址：https://router.vuejs.org/zh/api/#router-onerror

当使用路由参数时，例如从 `/user/foo` 导航到 `/user/bar`，**原来的组件实例会被复用**。因为两个路由都渲染同个组件，比起销毁再创建，复用则显得更加高效。**不过，这也意味着组件的生命周期钩子不会再被调用**。——因为组件是复用的，并不是销毁后重新创建，没有创建，就不会调用组件的生命周期钩子

复用组件时，想对路由参数的变化作出响应的话，你可以简单地 watch (监测变化) `$route` 对象：

```js
const User = {
  template: '...',
  watch: {
    $route(to, from) {
      // 对路由变化作出响应...
    }
  }
}
```

实例：

```js
    const User = {
      template: '<div>User {{$route.params.id}}</div>',
      watch: { //检测组件$route对象的变化
        $route(to, from) {
          console.log(to, from);
        }
      }
    }
    const routes = [{
        path: '/user/:id',//匹配路径user/动态值
        component: User
      }
    ]
```

**to和from都是路由$route对象：**

```json
fullPath: "/user/bar"
hash: ""
matched: [{…}]
meta: {}
name: undefined
params: {id: "bar"}
path: "/user/bar"
query: {}
```



或者使用导航卫士：

```js
const User = {
  template: '...',
  beforeRouteUpdate(to, from, next) {
    // react to route changes...
    // don't forget to call next()
  }
}
```

to和from也是$route对象

```json
fullPath: "/user/bar"
hash: ""
matched: [{…}]
meta: {}
name: undefined
params: {id: "bar"}
path: "/user/bar"
query: {}
```

next是一个函数

### 捕获所有路由或404 Not Found路由

常规参数只会匹配被 `/` 分隔的 URL 片段中的字符。如果想匹配**任意路径**，我们可以使用通配符 (`*`)：

```js
{
  // 会匹配所有路径
  path: '*'
}
{
  // 会匹配以 `/user-` 开头的任意路径
  path: '/user-*'
}
```

路由顺序 ：当使用*通配符*路由时，请确保路由的顺序是正确的，也就是说含有*通配符*的路由应该放在最后。路由 `{ path: '*' }` 通常用于客户端 404 错误。**——剩余其他的的所有路径，都走*路由。**

如果你使用了*History 模式*，请确保[正确配置你的服务器](https://router.vuejs.org/zh/guide/essentials/history-mode.html)。

当使用一个*通配符*时，`$route.params` 内会自动添加一个名为 `pathMatch` 参数。它包含了 URL 通过*通配符*被匹配的部分：

```js
// 给出一个路由 { path: '/user-*' }
this.$router.push('/user-admin')
this.$route.params.pathMatch // 'admin'
// 给出一个路由 { path: '*' }
this.$router.push('/non-existing')
this.$route.params.pathMatch // '/non-existing'
```