<template>
  <div id="settingPage">
    <div class="detail-body">
      <div class="body-head">
        <div>
          <p class="body-title">{{ unit_name }}</p>
        </div>
        <el-link class="backBtn" type="primary" :underline="false" @click="back"
          >返回</el-link
        >
      </div>
      <div class="body-main">
        <el-table height="80vh" :data="judger_list" style="width: 100%">
          <el-table-column prop="judger" label="阅卷人学号姓名">
          </el-table-column>
          <el-table-column prop="grouped" label="设置分组">
            <template slot-scope="scope">
              <el-select
                v-model="scope.row.grouped"
                allow-create
                @change="changeValue($event, scope.row.judgerId)"
                placeholder="请选择"
              >
                <el-option
                  v-for="item in options"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value"
                >
                </el-option>
              </el-select>
            </template>
          </el-table-column>
          <el-table-column fixed="right" label="操作" key="slot">
            <template>
              <el-button
                size="mini"
                type="primary"
                plain
                cursor:pointer
                @click="handleDelete"
                >删除</el-button
              >
            </template>
          </el-table-column>
        </el-table>
        <div class="describe_info" style="width: 12vw">
          <div class="title-info">
            <h2>问题总数: {{ total_judged_num }}</h2>
          </div>
          <div class="do-info">
            <el-button
              size="small"
              style="margin-top: 1vh; font-size: 10px; padding: 1vh"
              type="primary"
              @click="Clear"
              >一键删除</el-button
            >
            <div
              style="
                font-size: 1.4vh;
                margin-top: 1vh;
                display: flex;
                flex-direction: row;
                white-space: nowrap;
                justify-content: space-around;
                align-items: center;
              "
            >
              添加阅卷人:<el-input
                v-model="newOperator"
                placeholder="输入已有用户学号"
                @change="addOperator"
                size="small"
                style="margin-left: 0.5vw"
              ></el-input>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import {
  getOperatorInfo, // 获取阅卷人信息
  setOperatorGroup, // 设置阅卷人分组
  updateOperator, // 添加阅卷人
} from "../../api/admin";
export default {
  data() {
    return {
      unit_name: "",
      newOperator: "",
      // rightInfo: {},
      total_judged_num: 0,
      total_finished_num: 0,
      judger_list: [],
      headerObj: {
        token: localStorage.getItem("token"),
      },
      options: [
        {
          value: "政治",
          label: "政治",
        },
        {
          value: "英语",
          label: "英语",
        },
        {
          value: "数学",
          label: "数学",
        },
        {
          value: "408",
          label: "408",
        },
      ],
     
    };
  },
  mounted() {
    if (localStorage.getItem("role") === "2") {
      console.log(this.$route.params);
      getOperatorInfo(this.$route.params.unit_id).then((res) => {
        let judger_list = res.data.data.judger_list;
        console.log(judger_list);
        this.unit_name = res.data.data.unit_name;
        for (let item of judger_list) {
          item.judger = item.judgerId + item.judgerName;
        }
        this.judger_list = judger_list;
        this.total_finished_num = res.data.data.total_finished_num;
        this.total_judged_num = res.data.data.total_judged_num;
      });
    } else {
      this.$router.back();
    }
  },
  methods: {
    back() {
      this.$router.push("/adminhome");
      location.reload();
    },
    // 删除阅卷人
    handleDelete() {
      this.$message({
        message: "删不掉，怎么想都删不掉",
        type: "error",
      });
      //   var tableData = this.tableData;
      //   this.tableData = tableData.splice(index, 1);
    },
    Clear() {
      this.$message({
        message: "请不要这样做",
        type: "warning",
      });
    },

    // 设置分组
    changeValue(event, stuId) {
      setOperatorGroup(stuId, event)
        .then((res) => {
          this.$message.success(res.data.msg);
        })
        .catch((error) => {
          console.error(error);
        });
    },
    // 添加阅卷人
    addOperator() {
      console.log(this.newOperator);
      updateOperator(this.newOperator).then((res) => {
        if (res.data.errMsg === "数据库中没有该用户!") {
          this.$message.error("数据库中没有此用户");
        } else {
          this.$message.success("添加成功");
          location.reload();
        }
        this.newOperator = "";
      });
    },
  },
};
</script>

<style scoped>
#settingPage {
  margin: auto;
  width: 70vw;
  background: #fff;
  padding: 4vh;
  border-radius: 0.5vw;
}
.body-head {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
}
.body-title {
  font-size: 3.3vh;
  font-weight: 900;
  color: rgba(33, 32, 32, 1);
}
.body-main {
  z-index: -10;
  display: flex;
  flex-direction: row;
}
.describe_info {
  margin-left: 2vw;
}
.describe_info {
  display: flex;
  flex-direction: column;
}
.do-info {
  display: flex;
  flex-direction: column;
}
.el-table thead tr {
  background-color: #f5f5f5 !important;
}
tr:nth-child(even) {
  background: #f5f5f5;
}
.el-table .success-row {
  background: #ffffff;
}
.title-info {
  font-size: 1.4vh;
  font-weight: 700;
  letter-spacing: 0px;
  color: rgba(33, 32, 32, 1);
  text-align: left;
  vertical-align: top;
}
.group-info {
  font-size: 1.5vh;
  font-weight: 400;
  letter-spacing: 0px;
  color: rgba(33, 32, 32, 1);
  line-height: 1.2vh;
  text-align: left;
  vertical-align: top;
}
.btn_info {
  font-size: 0.8vh;
  line-height: 0;
  margin-left: 0.2vw;
  color: gray;
}
</style>
