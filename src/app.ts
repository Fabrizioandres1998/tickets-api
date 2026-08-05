import express, { Application } from "express";
import helmet from "helmet";
import morgan from "morgan";
import cors from "cors";

const app: Application = express();

app.use(helmet());
app.use(cors());
app.use(morgan("dev"));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

export default app;
