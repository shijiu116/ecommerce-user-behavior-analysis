# 数据源说明

## 数据集信息

- **名称**：UserBehavior（淘宝用户行为数据集）
- **来源**：阿里天池公开数据集
- **地址**：https://tianchi.aliyun.com/dataset/649
- **时间范围**：2017-11-25 至 2017-12-03
- **记录数**：100,150,807 条
- **用户数**：987,994
- **商品数**：4,162,024
- **类目数**：9,439

## 字段说明

数据集为 CSV 格式，无表头，共 5 列：

| 列序号 | 字段名 | 类型 | 说明 |
|--------|--------|------|------|
| 1 | user_id | 整数 | 序列化后的用户 ID |
| 2 | item_id | 整数 | 序列化后的商品 ID |
| 3 | category_id | 整数 | 商品所属类目 ID |
| 4 | behavior_type | 字符串 | pv / fav / cart / buy |
| 5 | timestamp | 整数 | Unix 时间戳（秒级） |

## 行为类型说明

| 值 | 含义 |
|----|------|
| pv | 浏览 |
| fav | 收藏 |
| cart | 加购 |
| buy | 购买 |

## 下载与导入步骤

### 1. 下载数据

访问 https://tianchi.aliyun.com/dataset/649

完成阿里云账号登录与学生认证（如需要）后，下载 `UserBehavior.csv.zip`。

### 2. 解压

解压后得到 `UserBehavior.csv`，原始文件约 3.4GB。

### 3. 数据抽样（可选，推荐）

如果电脑性能有限，可以先截取前 100 万行：

- Windows：用 PowerShell 执行
  ```powershell
  Get-Content UserBehavior.csv -TotalCount 1000000 | Set-Content UserBehavior_part.csv