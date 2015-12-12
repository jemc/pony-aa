
use "ponytest"

actor Main is TestList
  new create(env: Env) =>
    let test = PonyTest(env, this)
  
  fun tag tests(test: PonyTest) =>
    test(_TestAA)

class _TestAA is UnitTest
  var _foo: String = "foo"
  
  fun name(): String => "aa/AA"
  fun foo(): String => _foo
  
  fun apply(h: TestHelper): TestResult? =>
    h.expect_eq[USize](AA.obj_id(this), AA.obj_id(this))
    h.expect_eq[USize](AA.obj_id(h), AA.obj_id(h))
    h.expect_false(AA.obj_id(this) == AA.obj_id(h))
    
    let this_id = AA.obj_id(this)
    h.expect_true(AA.obj_from_id[Any](this_id) is this, "obj_from_id[Any]")
    h.expect_true(AA.obj_from_id[this->_TestAA](this_id) is this, "obj_from_id")
    
    h.expect_error(lambda()? => AA.get_main[Any]() end, "get_main NULL")
    AA.set_main(this)
    h.expect_true(AA.get_main[Any]() is this, "get_main[Any]")
    h.expect_true(AA.get_main[this->_TestAA]() is this, "get_main")
    h.expect_error(lambda()? => AA.set_main(this) end, "set_main again")
    
    true
