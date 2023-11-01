<template>
  <div class="uploadPage">
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
        <div class="description">
          <p v-html="unit_description"></p>
        </div>
        <div class="title-body">
          <div
            class="user-title"
            v-for="(item, index) in problem_list"
            :key="item.problem_id"
          >
            <div class="title-head">
              <div>{{ index + 1 }}.</div>
              <el-tag class="tag">{{ item.problem_type }}</el-tag>
              （{{ item.problem_total_score }}分）
              <div v-html="item.problem_description"></div>
              <span>（答案：{{ item.correct_answer }}）</span>
            </div>
            <div class="title-content">
              <div class="radioBox" v-if="item.problem_type === '单选'">
                <label
                  ><input
                    disabled
                    type="radio"
                    v-model="item.answer"
                    :name="item.problem_id"
                    value="A"
                  />&nbsp;{{ item.A }}</label
                >
                <label
                  ><input
                    disabled
                    type="radio"
                    v-model="item.answer"
                    :name="item.problem_id"
                    value="B"
                  />&nbsp;{{ item.B }}</label
                >
                <label
                  ><input
                    disabled
                    type="radio"
                    v-model="item.answer"
                    :name="item.problem_id"
                    value="C"
                  />&nbsp;{{ item.C }}</label
                >
                <label
                  ><input
                    disabled
                    type="radio"
                    v-model="item.answer"
                    :name="item.problem_id"
                    value="D"
                  />&nbsp;{{ item.D }}</label
                >
              </div>
              <div class="radioBox" v-if="item.problem_type === '判断'">
                <label
                  ><input
                    disabled
                    type="radio"
                    v-model="item.answer"
                    :name="item.problem_id"
                    value="true"
                  />&nbsp;对</label
                >
                <label
                  ><input
                    disabled
                    type="radio"
                    v-model="item.answer"
                    :name="item.problem_id"
                    value="false"
                  />&nbsp;错</label
                >
              </div>
              <div class="radioBox" v-if="item.problem_type === '填空'">
                <input disabled :name="item.problem_id" style="width: 200px" />
              </div>
            </div>
          </div>
        </div>
        <div class="title-footer" style="margin-top: 2vh">
          <el-button
            type="primary"
            @click="dialogFormVisible = true"
            style="width: 10vw; height: 5vh"
            >上传题目</el-button
          >
        </div>
      </div>
      <el-dialog
        title="新建题目"
        :visible.sync="dialogFormVisible"
        @click="newTitle"
      >
        <el-form :model="form">
          <el-form-item
            label="题目"
            :label-width="formLabelWidth"
            :rules="rules"
            prop="titleContent"
          >
            <el-input
              type="textarea"
              :row="2"
              v-model="form.problemDescription"
              autocomplete="off"
            ></el-input>
          </el-form-item>
          <el-form-item
            label="题目类型"
            :label-width="formLabelWidth"
            :rules="rules"
            prop="titleType"
          >
            <el-select v-model="form.problemType" placeholder="题目类型">
              <el-option label="单选" value="单选"></el-option>
              <el-option label="判断" value="判断"></el-option>
              <el-option label="填空" value="填空"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item
            label="题目分数"
            :label-width="formLabelWidth"
            :rules="rules"
            prop="titleScore"
          >
            <el-input-number
              v-model="form.problemScore"
              change="handleChange"
              :min="1"
              :max="10"
              label="题目分数"
            ></el-input-number>
          </el-form-item>
          <el-form-item
            v-if="form.problemType === '单选'"
            label="A"
            :label-width="formLabelWidth"
          >
            <el-input
              v-model="form.optionA"
              autocomplete="off"
            ></el-input> </el-form-item
          ><el-form-item
            v-if="form.problemType === '单选'"
            label="B"
            :label-width="formLabelWidth"
          >
            <el-input
              v-model="form.optionB"
              autocomplete="off"
            ></el-input> </el-form-item
          ><el-form-item
            v-if="form.problemType === '单选'"
            label="C"
            :label-width="formLabelWidth"
          >
            <el-input
              v-model="form.optionC"
              autocomplete="off"
            ></el-input> </el-form-item
          ><el-form-item
            v-if="form.problemType === '单选'"
            label="D"
            :label-width="formLabelWidth"
          >
            <el-input v-model="form.optionD" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="答案" :label-width="formLabelWidth">
            <el-input
              v-if="form.problemType === '填空'"
              v-model="form.answer"
              autocomplete="off"
            ></el-input>

            <el-select
              v-if="form.problemType === '单选'"
              v-model="form.answer"
              placeholder="答案"
            >
              <el-option label="A" value="A"></el-option>
              <el-option label="B" value="B"></el-option>
              <el-option label="C" value="C"></el-option>
              <el-option label="D" value="D"></el-option>
            </el-select>
            <el-select
              v-if="form.problemType === '判断'"
              v-model="form.answer"
              placeholder="答案"
            >
              <el-option label="对" value="对"></el-option>
              <el-option label="错" value="错"></el-option> </el-select
          ></el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button
            @click="dialogFormVisible = false"
            style="margin-right: 1vw"
            >取 消</el-button
          >
          <el-button type="primary" @click="submitNewTitle">确 定</el-button>
        </div>
      </el-dialog>
    </div>
  </div>
</template>

<script>
import { upLoadNewTitle } from "../../api/admin";
import { getCompetetionListDetail } from "../../api/user";
export default {
  name: "admin-upload",
  data() {
    return {
      unit_name: "",
      unit_description: "",
      problemDescription: "",
      problemType: "",
      problemGroup: "",
      problem_list: [],
      answer: [],
      headerObj: {
        token: localStorage.getItem("token"),
      },
      dialogTableVisible: false,
      dialogFormVisible: false,
      form: {
        problemDescription: "",
        problemType: "单选",
        problemScore: 1,
        optionA: "",
        optionB: "",
        optionC: "",
        optionD: "",
        optionYes: "",
        optionNo: "",
        isLoad: "否",
        answer: "",
      },
      formLabelWidth: "120px",
      rules: {
        titleContent: {
          require: true,
          message: "请输入题目内容",
          trigger: "blur",
        },
        titleType: {
          require: true,
          message: "请输入题目类型",
          trigger: "blur",
        },
        titleScore: {
          require: true,
          message: "请输入题目分数",
          trigger: "blur",
        },
      },
    };
  },
  methods: {
    back() {
      this.$router.push("/adminhome");
      location.reload();
    },
    newTitle() {
      this.form = {
        problemDescription: "",
        problemType: "单选",
        problemScore: 1,
        optionA: "",
        optionB: "",
        optionC: "",
        optionD: "",
        isLoad: "否",
        answer: "",
      };
    },
    // 上传题目
    submitNewTitle() {
      if (this.form.problemDescription === "") {
        this.$message.warning("请输入题目内容");
      } else if (
        this.form.problemType !== "填空" &&
        this.form.problemType !== "判断" &&
        (this.form.optionA === "" ||
          this.form.optionB === "" ||
          this.form.optionC === "" ||
          this.form.optionD === "")
      ) {
        this.$message.warning("请输入选项内容");
      } else {
        upLoadNewTitle(this.$route.params.unit_id, this.form).then((res) => {
          if (res.data.success === true) {
            this.$message.success("上传成功");
            setTimeout(() => {
              location.reload();
            }, 2000);
          } else {
            this.$message.error("上传失败,请重试");
          }
        });
        this.dialogFormVisible = false;
      }
    },
  },
  async created() {
    let problem_list = [];
    await getCompetetionListDetail(
      this.$router.currentRoute.params.unit_id
    ).then(({ data: { data } }) => {
      problem_list = data.problem_list;
      console.log(data.problem_list);
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
      });
    });
    this.problem_list = problem_list;

    if (location.href.indexOf("#reload") !== -1) {
      location.href = location.href + "#reload";
      location.reload();
    }
  },
};
</script>

<style scoped>
.uploadPage {
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
  white-space: pre-wrap;
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
  padding: 0 20px;
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
label .el-input {
  margin-top: 2vh;
}
label {
  display: flex;
  align-items: center;
  flex-direction: row;
  flex-wrap: nowrap;
}
form {
  margin-top: 2vh;
}
.dialog-footer {
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: flex-end;
}
</style>
