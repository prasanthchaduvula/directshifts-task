import axios from "axios";

const create = payload => axios.post("/api/v1/invitations", payload);

const invitationApi = {
  create,
};

export default invitationApi;
