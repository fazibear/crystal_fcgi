@[Link("fcgi")]
lib FCGX
  struct Params
    vec: UInt8**
    length: Int8
    cur: UInt8**
  end

  struct Stream
    rd_next: UInt8*
    wr_next: UInt8*
    stop: UInt8*
    stop_unget: UInt8*
    is_reader: Int8
    is_closed: Int8
    was_fclose_called: Int8
    fcgi_errno: Int8
  end

  struct Request
    request_id: Int32
    role: Int32
    in: Stream*
    out: Stream*
    err: Stream*

    envp: Int8**
    params: Params*

    ipc_fd: Int8
    isBeginProcessed: Int8
    keepConnection: Int8
    appStatus: Int8
    nWriters: Int8
    flags: Int8
    listen_sock: Int8
    detached: Int8
  end

  fun init = FCGX_Init(): Int32
  fun init_request = FCGX_InitRequest(request: Request*, sock: Int32, flags: Int32): Int32
  fun accept_r = FCGX_Accept_r(request: Request*): Int32
  fun put_s = FCGX_PutS(str: UInt8*, stream: Stream*)
  fun get_param = FCGX_GetParam(name: UInt8*, envp: Int8**): UInt8*
end
