export const callUserTable = ({ memberId }) => {
	const requestURL = `http://${process.env.REACT_APP_RESTAPI_IP}:8080/api/v1/members/${memberId}`;

	return async (dispatch, getState) => {
		// 클라이언트 fetch mode : no-cors 사용시 application/json 방식으로 요청이 불가능
		// 서버에서 cors 허용을 해주어야 함
		const result = await fetch(requestURL, {
			method: "GET",
			headers: {
				"Content-Type": "application/json",
				Accept: "*/*",
				Authorization: "Bearer " + window.localStorage.getItem("accessToken"),
			},
		}).then(response => response.json());

		console.log("[MemberAPICalls] callGetMemberAPI RESULT : ", result);

		dispatch({ type: GET_MEMBER, payload: result });
	};
};