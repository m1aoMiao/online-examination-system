<template>
  <div class="Login">
    <div class="login-tarBar">
      <img
        src="../../public/image/CS.jpg"
        alt="logo"
        style="margin-top: 3.2vh;
        width: 120px;"
      />
      <p>课程在线练习系统</p>
    </div>
    <div class="login-body">
      <h1 class="title" style="color: rgba(64, 153, 237, 1)">登录账号</h1>
      <el-form ref="form" :model="form" class="from" :rules="rules">
        <el-form-item class="inputBox" prop="username">
          <el-input
            placeholder="学号 / 邮箱"
            @keydown.enter.native="nextinput"
            v-model.trim="form.username"
            clearable
            maxlength="20vw"
          >
          </el-input>
        </el-form-item>
        <el-form-item class="inputBox" prop="password">
          <el-input
            id="nextipt"
            placeholder="密码"
            v-model.trim="form.password"
            @keydown.enter.native="handleLogin"
            show-password
          ></el-input>
        </el-form-item>
        <el-form-item>
          <el-button class="btn" type="primary" @click="handleLogin" plain
            >登录</el-button
          >
        </el-form-item>
      </el-form>
      <!-- </router-link> -->
      <a class="linkTo" href="./changePassword">修改密码</a>
      <img
        class="backimg"
        src="../../public/image/loginback.png"
        alt="backimg"
      />
    </div>
    <div class="box"></div>
  </div>
</template>

<script>
import { nameRule, passRule } from "../utils/vaildate";
import { login } from "../api/index";
export default {
  name: "sacc-login",
  data() {
    return {
      form: {
        username: "",
        password: "",
      },
      rules: {
        username: [{ validator: nameRule, trigger: "blur" }],
        password: [{ validator: passRule, trigger: "blur" }],
      },
    };
  },
  methods: {
    nextinput() {
      const nextipt = document.querySelector("#nextipt");
      nextipt.focus();
    },
    handleLogin() {
      login(this.form.username, this.form.password).then((res) => {
        localStorage.setItem("userID", this.form.username);
        if (res.data.msg === "不存在的用户") {
          this.$message.error("账号不存在");
        } else if (res.data.msg === "密码错误") {
          this.$message.error("密码错误");
        } else {
          localStorage.setItem("role", res.data.data.role);
          localStorage.setItem("refresh", 0);
          this.$store.commit(
            "LOGIN_IN",
            res.data.data.token,
            res.data.data.role
          );
          if (res.data.data.role === "0") {
            this.$router.push("/userhome");
          } else if (res.data.data.role === "1") {
            this.$router.push("/operatorhome");
          } else if (res.data.data.role === "2") {
            this.$router.push("/adminhome");
          }
        }
      });
    },
  },
};
</script>

<style scoped>
.Login {
  /* min-width: 900px; */
  display: flex;
  height: auto ;
  flex-direction: column;
  align-items: center;
}
.login-tarBar {
  text-align: center;
  flex-direction: column;
  align-content: center;
}
.login-tarBar p {
  color: rgba(33, 32, 32, 1);
  letter-spacing: 7px;
  line-height: 5.5vh;
  font-size: 3.5vh;
  font-weight: 900;
}
.login-body {
  position: relative;
  padding: 1vw;
  display: flex;
  flex-direction: column;
  z-index: 100;
  align-items: center;
  width: 50vw;
  height: 48vh;
  margin-top: 2vh;
  background: rgba(255, 255, 255, 1);
  box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.25);
  border-radius: 2.7vh;
}
.login-body .inputBox {
  width: 20vw;
  margin-bottom: 5vh;
  display: flex;
  flex-direction: row;
  align-items: center;
}
::v-deep .login-body input {
  width: 20vw;
  height: 6vh;
  background: rgba(245, 245, 245, 1);
  border-radius: 1.5vh;
  font-size: 2.2vh;
  font-weight: 500;
  padding-left: 1vh;
  vertical-align: auto;
}
.el-button.is-round {
  border-radius: 20px;
  padding: 0rem;
}
.el-button {
  display: inline-block;
  white-space: nowrap;
  cursor: pointer;
  background: #fff;
  border: 1px solid #dcdfe6;
  color: #2277aa;
  -webkit-appearance: none;
  box-sizing: border-box;
  outline: 0;
  margin: 0;
  transition: 0.1s;
  font-weight: 500;
  font-size: 2.2vh;
  border-radius: 4px;
}
.btn {
  /* width: 8vw; */
  height: 6vh;
  padding: 0 3vw;
  background: rgba(4, 134, 254, 1);
  border-radius: 4px;
  color: rgba(255, 255, 255, 1);
  font-size: 2.2vmin;
  font-weight: 400;
  margin-top: 1vh;
}
.linkTo {
  font-size: 1.5vh;
  font-weight: 400;
  letter-spacing: 0px;
  line-height: 0px;
  color: rgba(64, 153, 237, 1);
  text-decoration: none;
}
.backimg {
  position: absolute;
  /* width: 10.4vw; */
  height: 21.2vmin;
  right: 0vw;
  top: 24vh;
}
.from {
  display: flex;
  flex-direction: column;
  align-items: center;
}
.box {
  height: 18.9vh;
}
</style>
