using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace MSBuild.NET.Tasks.Tests;

[TestClass]
public class MainTest //: TaskTest
{
	[TestMethod]
	public void TestThis()
	{
		var actual = 1;
		var expected = 1;
		Assert.AreEqual(expected, actual);
	}
}