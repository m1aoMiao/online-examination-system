<template>
  <div class="sacc-changePassword">
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
      <h1 class="title" style="color: rgba(64, 153, 237, 1)">修改密码</h1>
      <div class="inputBox">
        <el-input placeholder="学号" v-model="user" clearable maxlength="20vw">
        </el-input>
      </div>
      <div class="inputBox">
        <el-input
          placeholder="输入原密码"
          v-model="oldpassword"
          clearable
          maxlength="20vw"
        >
        </el-input>
      </div>
      <div class="inputBox">
        <el-input placeholder="输入密码" v-model="newpassword" show-password>
        </el-input>
      </div>
      <div class="inputBox">
        <el-input
          placeholder="确认密码"
          v-model="truepassword"
          show-password
        ></el-input>
      </div>
      <div>
        <el-button class="btn" type="primary" :plain="true" @click="back"
          >返回</el-button
        >
        <el-button
          class="btn"
          type="primary"
          :plain="true"
          @click="handleRegister"
          >确认</el-button
        >
      </div>
      <img
        class="backimg"
        src="../../public/image/loginback.png"
        alt="backimg"
      />
    </div>
  </div>
</template>

<script>
import { changePassword } from "../api/index";
export default {
  name: "sacc-changePassword",
  data() {
    return {
      user: "",
      oldpassword: "",
      newpassword: "",
      truepassword: "",
    };
  },
  methods: {
    handleRegister() {
      if (this.newpassword == "" || null) {
        this.$message.warning("新密码不能为空");
      } else {
        if (this.newpassword === this.truepassword) {
          changePassword(this.user, this.oldpassword, this.newpassword).then(
            (res) => {
              if (res.data.errMsg === "mysql中没有对应的账号") {
                this.$message({
                  message: "该学号不存在, 请联系管理员创建",
                  type: "warning",
                });
              } else if (res.data.errMsg === "原密码错误!") {
                this.$message({
                  message: "原密码输入错误",
                  type: "warning",
                });
              } else {
                this.$message({
                  message: "修改密码成功, 回到登录界面",
                  type: "success",
                });
                this.$router.push("/login");
              }
            }
          );
        } else {
          this.$message({
            message: "两次密码输入不一致",
            type: "warning",
          });
        }
      }
    },
    back() {
      this.$router.back();
    },
  },
};
</script>

<style>
.sacc-changePassword {
  display: flex;
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
  height: 50vh;
  background: rgba(255, 255, 255, 1);
  box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.25);
  border-radius: 2.7vh;
}
.login-body .inputBox {
  width: 20vw;
  margin-bottom: 2.5vh;
  display: flex;
  flex-direction: row;
  align-items: center;
}
.login-body input {
  width: 20vw;
  height: 5vh;
  background: rgba(245, 245, 245, 1);
  border-radius: 1.5vh;
  font-size: 2.2vh;
  font-weight: 500;
  padding-left: 1vh;
  vertical-align: auto;
}
.btn {
  padding: 1vh 2.5vw;
  background: rgba(4, 134, 254, 1);
  border-radius: 4px;
  color: rgba(255, 255, 255, 1);
  font-size: 2.2vh;
  font-weight: 400;
  margin: 1vh 1.5vw;
}
.backimg {
  position: absolute;
  width: 10.4vw;
  height: 21.2vh;
  left: 40vw;
  top: 26vh;
}
</style>
