<template>
  <div class="gradePage">
    <div class="answer-content">
      <div class="content-body">
        <div class="top-head">
          <p class="body-title">{{ unit_name }}</p>
          <span class="user-info"
            ><p style="color: #2a82e4; margin-left: 2vw">答题人：</p>
            <p>{{ this.$route.params.stuId }}</p></span
          >
          <div class="space"></div>
          <el-link
            class="backBtn"
            type="primary"
            @click="back"
            :underline="false"
            >返回</el-link
          >
          <el-link
            class="nextBtn"
            type="primary"
            @click="next"
            :underline="false"
            >下一份</el-link
          >
        </div>
        <div class="description" v-html="unit_description"></div>
        <div class="title-body">
          <div
            class="user-title"
            v-for="(item, index) in problem_list"
            :key="item.problemId"
          >
            <div class="title-head">
              <div>{{ index + 1 }}.</div>
              <el-tag class="tag">{{ item.problem_type }}</el-tag>
              <div v-html="item.problemDescription"></div>
            </div>
            <div class="title-content">
              <div class="radioBox" v-if="item.problem_type === '单选'">
                <label
                  ><input
                    type="radio"
                    :name="item.problemId"
                    v-model="item.value"
                    value="A"
                    disabled
                  />&nbsp;{{ item.optionA }}</label
                >
                <label
                  ><input
                    type="radio"
                    :name="item.problemId"
                    v-model="item.value"
                    value="B"
                    disabled
                  />&nbsp;{{ item.optionB }}</label
                >
                <label
                  ><input
                    type="radio"
                    :name="item.problemId"
                    v-model="item.value"
                    value="C"
                    disabled
                  />&nbsp;{{ item.optionC }}</label
                >
                <label
                  ><input
                    type="radio"
                    :name="item.problemId"
                    v-model="item.value"
                    value="D"
                    disabled
                  />&nbsp;{{ item.optionD }}</label
                >
              </div>
              <div class="inputBox" v-else-if="item.problem_type === '填空'">
                <el-input
                  class="input"
                  v-model="item.value"
                  placeholder="在此输入你的答案"
                  disabled
                />
              </div>
            </div>
            <div class="title-score">
              <p>分数：</p>
              <input
                disabled
                class="score-input"
                v-model="item.problemScore"
                type="number"
                placeholder="请输入得分"
              />
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { getNextStuId, getOneDetail } from "../../api/operator";

export default {
  name: "grade-page",
  data() {
    return {
      problem_list: [],
      unit_name: "",
      unit_description: "",
      scoreInput: [],
      nextStuId: "",
    };
  },
  methods: {
    // 返回
    back() {
      this.$router.go(-1);
    },
    // 下一份
    next() {
      getNextStuId(this.$route.params.stuId).then((res) => {
        console.log(res.data, "nextstuId");
        if (res.data.data === "null" || "") {
          this.$message.success("这是最后一份");
        } else {
          this.$router.push(
            `/operatorhome/answer/${this.$router.currentRoute.params.unit}/${res.data.data}`
          );
          location.reload();
        }
      });
    },
  },
  async mounted() {
    // 调用获取某次答题情况的借口
    if (localStorage.getItem("role") === "1") {
      getOneDetail(this.$route.params.unit_id, this.$route.params.stuId).then(
        (res) => {
          console.log(res);
          if (res.data.data === "null") {
            this.$router.back(-1);
            this.$message.warning("该学号不存在");
          } else {
            let problem_list = res.data.data.problem_list;
            problem_list.forEach((item) => {
              if (item.problemType === "单选题") {
                item.problem_type = "单选";
                item.value = item.answer;
              } else if (item.problemType === "判断题") {
                item.problem_type = "判断";
                item.value = item.answer;
              } else {
                item.problem_type = "填空";
                item.value = item.answer;
              }
            });
            this.unit_name = res.data.data.unit_name;
            this.unit_description = res.data.data.unit_description;
            this.problem_list = problem_list;
            console.log(this.problem_list);
          }
        }
      );
    }
  },
};
</script>

<style scoped>
.gradePage {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.answer-content {
  width: 70vw;
  height: auto;
  background: rgba(255, 255, 255, 1);
  border-radius: 1.4vh;
}

.top-head {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
}

.content-body {
  padding: 4vh 5vh;
}

.body-title {
  font-size: 3.3vh;
  font-weight: 900;
  letter-spacing: 0px;
  line-height: 0px;
  color: rgba(33, 32, 32, 1);
}

.description {
  font-size: 1.4vh;
  font-weight: 400;
  letter-spacing: 0px;
  color: rgba(0, 0, 0, 0.65);
}

.title-content {
  padding-bottom: 2vh;
  border-style: dashed;
  border: 0px;
  border-bottom: 2px dashed;
  border-color: rgb(221, 221, 221);
}

.user-info {
  display: flex;
  flex-direction: row;
  justify-content: flex-start;
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

.space {
  margin: auto;
}

.backBtn {
  margin-right: 1vw;
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

/* input框获得焦点取消placeholder样式 */
input:focus::-webkit-input-placeholder {
  color: transparent;
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

.title-score {
  display: flex;
  flex-direction: row;
  align-items: center;
  width: 100%;
  height: 7vh;
  background: rgba(229, 229, 229, 1);
  border-radius: 0.7vh;
  padding: 0 1.5vw;
  box-sizing: border-box;
}

.score-input {
  background-color: rgb(131, 131, 131);
  outline-style: none;
  height: 3vh;
  width: 7vw;
  border: none;
  color: rgb(174, 9, 9);
  font-size: 2vh;
  padding-left: 0.7vw;
  border-radius: 0.4vh;
  caret-color: black;
}

/* 设置placeholder的字体样式 */
.score-input::-webkit-input-placeholder {
  color: #fff;
}
</style>
