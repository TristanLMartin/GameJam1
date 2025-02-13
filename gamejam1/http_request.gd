extends HTTPRequest

var leaderboard_rankings = []

func request_leaderboard()-> void:
	print('attempting to fetch leaderboard')
	# Create an HTTP request node and connect its completion signal.
	var http_request = HTTPRequest.new()
	add_child(http_request)
	await http_request.request_completed.connect(await self._http_request_completed)

	# Perform a GET request. The URL below returns JSON as of writing.
	var error = http_request.request("http://129.146.218.51:5000/get_leaderboard")
	if error != OK:
		push_error("An error occurred in the HTTP request.")


func update_leaderboard(username, wave) -> void:
	print('attempting to update leaderboard')
	var http_request = HTTPRequest.new()
	add_child(http_request)
	var body = JSON.new().stringify({"username": username, "score" : wave})
	var error = http_request.request("http://129.146.218.51:5000/post_record", ['Content-Type: application/json'], HTTPClient.METHOD_POST, body)
	if error != OK:
		push_error("An error occurred in the HTTP request.")
	else:
		%HTTPRequest.request_leaderboard()
	

# Called when the HTTP request is completed.
func _http_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	leaderboard_rankings = response
