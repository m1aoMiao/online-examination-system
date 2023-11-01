// 各页面通用组件 topHead
<template>
  <div>
    <div class="head"></div>
    <div class="topHead">
      <div style="display: inline-block;width: 20px;"></div>
      <img
        class="logo"
        src="../../public/image/logo.png"
        alt="logo"
        style="margin-top: 3.2vh"
      />
      <div class="end">
        <div class="block">
          <img
            src="../../public/image/avatar.png"
            alt="头像"
            style="object-fit: cover; height: 3.8vh; width: 3.8vh"
          />
        </div>
        <p class="avatar-name">{{ username }}</p>
        <router-link :to="{ path: '/login' }">
          <p class="out" @click="exit">退出登录</p>
        </router-link>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "topHead",
  data() {
    return {
      username: "",
    };
  },
  methods: {
    exit() {
      this.$store.commit("LOGIN_OUT", "token");
    },
  },
  mounted() {
    this.username = localStorage.getItem("userID");
  },
};
</script>

<style>
.head {
  height: 7.4vh;
  margin-bottom: 3vh;
}
.topHead {
  z-index: 10;
  position: fixed;
  left: 0;
  top: 0;
  width: 100vw;

  padding: 0;
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  background-color: rgb(254, 254, 254);
  height: 7.4vh;
}
.logo {
  margin-bottom: 2.5vh;
  height: 3.8vh;
}
.end {
  display: flex;
  flex-flow: row nowrap;
  align-items: center;
  /* margin-right: 3vw; */
}
.avatar-name {
  font-size: 1.5vh;
  font-weight: 400;
  letter-spacing: 0px;
  line-height: 2vh;
  color: rgba(33, 32, 32, 1);
  text-align: left;
  margin-left: 0.5vw;
  margin-right: 1vw;
}
.out {
  font-size: 1.5vh;
  font-weight: 400;
  letter-spacing: 0px;
  line-height: 0px;
  color: rgba(4, 134, 254, 1);
}
/* 消除router-link下划线 */
a {
  text-decoration: none;
}
.router-link-active {
  text-decoration: none;
}
.avatar {
  object-fit: cover;
}
</style>

