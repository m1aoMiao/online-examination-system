<template>
  <div class="AnswerPage">
    <router-view></router-view>
    <div class="answer-content">
      <div class="content-body">
        <div class="top-head">
          <p class="body-title">{{ unit_name }}</p>
          <el-link
            class="backBtn"
            type="primary"
            :underline="false"
            @click="back"
            >返回</el-link
          >
        </div>
        <div class="description" v-html="description"></div>
        <div class="title-body">
          <div
            class="user-title"
            v-for="(item, index) in problem_list"
            :key="item.id"
          >
            <div class="title-head">
              <div>{{ index + 1 }}.</div>
              <el-tag class="tag">{{ item.problem_type }}</el-tag>
              （{{ item.problem_total_score }}分）
              <div v-html="item.problem_description"></div>
            </div>
            <div class="img" v-if="item.picture_url !== null">
              <div v-for="(i, index) in item.picture_url" :key="index">
                <img
                  :src="i"
                  alt="图片"
                  style="height: 35vh; object-fit: fill; text-align: left"
                />
              </div>
            </div>
            <div class="title-content">
              <div class="radioBox" v-if="item.problem_type === '单选'">
                <label
                  ><input
                    type="radio"
                    v-model="item.value"
                    :name="item.id"
                    value="A"
                  />&nbsp;{{ item.A }}</label
                >
                <label
                  ><input
                    type="radio"
                    v-model="item.value"
                    :name="item.id"
                    value="B"
                  />&nbsp;{{ item.B }}</label
                >
                <label
                  ><input
                    type="radio"
                    v-model="item.value"
                    :name="item.id"
                    value="C"
                  />&nbsp;{{ item.C }}</label
                >
                <label
                  ><input
                    type="radio"
                    v-model="item.value"
                    :name="item.id"
                    value="D"
                  />&nbsp;{{ item.D }}</label
                >
              </div>
              <div class="radioBox" v-if="item.problem_type === '判断'">
                <label
                  ><input
                    type="radio"
                    v-model="item.value"
                    :name="item.id"
                    value="对"
                  />&nbsp;对</label
                >
                <label
                  ><input
                    type="radio"
                    v-model="item.value"
                    :name="item.id"
                    value="错"
                  />&nbsp;错</label
                >
              </div>
              <div class="inputBox" v-else-if="item.problem_type === '填空'">
                <el-input
                  class="input"
                  v-model="item.value"
                  placeholder="在此输入你的答案"
                />
              </div>
            </div>
          </div>
        </div>

        <div class="title-footer">
          <el-button
            type="primary"
            class="btn"
            cursor:pointer
            @click="submitAnswer"
            >提交</el-button
          >
        </div>
        <el-button
          type="primary"
          class="saveBtn"
          cursor:pointer
          @click="uploadAnswer"
        >
          保存
        </el-button>
      </div>
    </div>
  </div>
</template>

<script>
import { autoJudge, getCompetetionListDetail } from "../../api/user";
import { userAnswerSubmit } from "../../api/user";
export default {
  name: "user-answer",
  data() {
    return {
      unit_name: "",
      description: "",
      problem_list: [],
      answer: [],
    };
  },
  methods: {
    submitAnswer() {
      this.answer = [];
      for (let item of this.problem_list) {
        item.answer = item.value;
        this.answer.push({ problemId: item.problem_id, answer: item.answer });
      }
      autoJudge(this.answer, this.$router.currentRoute.params.unit_id).then(
        () => {
          this.$message({
            message: "提交成功",
            type: "success",
          });
          this.$router.push("/userhome/success");
        }
      );
    },
    uploadAnswer() {
      this.answer = [];
      for (let item of this.problem_list) {
        item.answer = item.value;
        this.answer.push({ problemId: item.problem_id, answer: item.answer });
      }
      userAnswerSubmit(this.answer, this.$router.currentRoute.params.unit_id)
        .then(() => {
          this.$message({
            message: "保存成功",
            type: "success",
          });
        })
        .catch(() => {
          this.$message({
            message: "保存失败,请重试",
            type: "warning",
          });
        });
    },
    back() {
      this.$router.push("/userhome");
      location.reload();
    },
  },
  created() {
    let problem_list = [];
    if (localStorage.getItem("role") === "0") {
      getCompetetionListDetail(this.$router.currentRoute.params.unit_id).then(
        ({ data: { data } }) => {
          problem_list = data.problem_list;
          this.unit_description = data.unit_description;
          this.unit_name = data.unit_name;
          problem_list.forEach((item) => {
            item.problem_description = item.problem_description.replace(
              /\r\n/g,
              "<br />"
            );
            item.problem_description = item.problem_description.replace(
              /\r/g,
              "&nbsp;&nbsp;"
            );
            if (item.problem_type === 0) {
              item.problem_type = "单选";
            } else if (item.problem_type === 4) {
              item.problem_type = "填空";
            } else if (item.problem_type === 3) {
              item.problem_type = "判断";
            }
            if (item.correct_answer === true) {
              item.correct_answer = "对";
            } else {
              item.correct_answer = "错";
            }
            item.value = item.answer;
          });

          this.problem_list = problem_list;
        }
      );
    } else {
      this.$router.back();
    }
  },
};
</script>

<style scoped>
.AnswerPage {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding-bottom: 3vh;
}
.answer-content {
  width: 60vw;
  height: auto;
  background: rgba(255, 255, 255, 1);
  border-radius: 1.4vh;
}
.top-head {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
}
.content-body {
  padding: 3vh 5vh;
}
.body-title {
  font-size: 3.3vh;
  font-weight: 900;
  letter-spacing: 0px;
  line-height: 0px;
  color: rgba(33, 32, 32, 1);
}
.description {
  font-size: 1.6vh;
  font-weight: 400;
  letter-spacing: 0px;
  color: rgba(0, 0, 0, 0.65);
}
.user-title {
  border-style: dashed;
  border: 0px;
  border-bottom: 2px dashed;
  border-color: rgb(221, 221, 221);
}
.title-body {
  margin-top: 3vh;
  background: rgba(245, 245, 245, 1);
  border-radius: 0.8vh;
  padding: 2vh 2vw;
}
.title-head {
  font-size: 2.2vh;
  font-weight: 400;
  color: rgba(0, 0, 0, 1);
  display: flex;
  flex-direction: row;
  align-items: flex-start;
  margin: 2vh 0;
}
.title-content {
  margin-bottom: 2vh;
}
.tag {
  margin: 0.3vh 0.3vw;
  border-radius: 2vh;
  height: 2.6vh;
  line-height: 2.5vh;
  font-size: 1vw;
  text-align: center;
  background-color: #2487f7;
  color: #fff;
}
.el-textarea__inner {
  background-color: rgb(228, 228, 228);
  outline: none;
  border-radius: 0.8vw;
}
.input {
  font-size: 1vw;
  color: #000;
}
.el-textarea__inner::-webkit-input-placeholder {
  color: #000;
  font-size: 1vw;
}
.radioBox {
  display: flex;
  flex-direction: column;
  justify-content: center;
  font-size: 1.8vh;
}
.checkBox {
  display: flex;
  flex-direction: column;
  justify-content: center;
  font-size: 1.8vh;
}
input {
  margin: 0.9vh 0;
}
.title-footer {
  display: flex;
  flex-direction: row;
  justify-content: center;
}
.btn {
  width: 7vw;
  margin: 4vh 2vw 0 2vw;
  font-size: 0.8vw;
}
.saveBtn {
  position: fixed;
  text-align: center;
  top: 100px;
  left: 10vw;
  padding: 1vh;
  z-index: 100;
  background-color: skyblue;
  border-radius: 5px;
}
</style>
