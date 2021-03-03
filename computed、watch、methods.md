# 计算属性computed、侦听属性watch、方法methods

属性指vue实例中data对象内的属性

### 计算属性computed

如果属性发生改变，将触发计算函数，得到计算属性值。

计算属性，在vue实例初始化时，会默认根据计算的属性去执行getter方法，从而得到计算属性值。

计算属性是依据他们的响应式依赖进行缓存的，该属性值就缓存在内存中。引用vue官网的案例：我们为什么需要缓存？假设我们有一个性能开销比较大的计算属性 **A**，它需要遍历一个巨大的数组并做大量的计算。然后我们可能有其他的计算属性依赖于 **A**。如果没有缓存，每次调用A时，都要重新计算，那样每次都会进行大量计算。我们将不可避免的多次执行 **A** 的 getter！如果你不希望有缓存，请用方法来替代。

计算属性默认是getter函数，所以处理函数要有return来返回值，赋值给计算属性。

当然也可以写成getter和setter的模式，setter函数在程序主动给计算属性设置时触发——此处有点类似侦听属性

```js
      computed: {
        personAge: function(){
          return this.firstName + '25';
        },
        personHobby: {
          get(){
            return this.fullName + 'travel'
          },
          set(val){//可接受参数setter新值
            console.log(val)
            this.travelCount ++;
            console.log(this.travelCount)
          }
        }
      },
```



### 侦听属性watch

`watch` 选项提供了一个更通用的方法，来响应数据的变化。当需要在数据变化时执行异步或开销较大的操作时，这个方式是最有用的。

侦听属性值的变化（vue实例的data对象的属性值），就会触发函数。

侦听函数的原理是setter方法，所以接收的参数val就是侦听属性本身的新值。

vue实例初始化时，不会根据data对象的值而触发侦听器。触发在程序中主动改变侦听属性。

```js
      watch: { // 如果 侦听的值发生改变，这个函数就会运行
        firstName: function (val) {
          console.log(val);
          this.fullName = val + ' ' + this.lastName
        },
        lastName: function (val) {
          this.fullName = this.firstName + ' ' + val
        }
      }
```



### 方法methods

（1）v-on监听事件

监听的事件处理函数，在methods对象中，处理函数的写法为`v-on:click="clickHandle()"`，如果不接收参数可以简写为`v-on:click="clickHandle"`



（2）普通方法调用，每次调用都重新执行，因为与计算属性的缓存有区别