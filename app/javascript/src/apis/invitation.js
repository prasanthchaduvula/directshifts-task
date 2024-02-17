import axios from "./api";

const get = () => axios.get("/api/v1/invitations");

const create = payload => axios.post("/api/v1/invitations", payload);

const invitationApi = {
  get,
  create,
};

export default invitationApi;
