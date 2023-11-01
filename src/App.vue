<template>
  <div id="app">
    <div class="bigBox">
      <router-view />
    </div>
  </div>
</template>

<style>
#app {
  position: relative;
  outline: none;
  background-image: url("/public/image/back-image.png");
  height: auto;
  background-repeat: no-repeat;
  background-attachment: fixed;
  background-size: cover;
}
.bigBox {
  height: 100vh;
  width: 100vw;
  padding: auto;
  overflow: scroll;
  overflow-x: hidden;
}

.bigBox::-webkit-scrollbar {
  /*滚动条整体样式*/
  width: 10px; /*高宽分别对应横竖滚动条的尺寸*/
  height: 10px;
}
.bigBox::-webkit-scrollbar-thumb {
  /*滚动条里面小方块*/
  border-radius: 10px;
  /* -webkit-box-shadow: inset 0 0 5px rgba(126, 126, 126, 0.2); */
  background: #b0b0b0;
}
.bigBox::-webkit-scrollbar-track {
  /*滚动条里面轨道*/
  /* -webkit-box-shadow: inset 0 0 5px rgba(193, 193, 193, 0.2); */
  border-radius: 10px;
  background: #ededed;
}
</style>