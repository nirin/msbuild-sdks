using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace MSBuild.NET.Sdk.Tests;

[TestClass]
public class MainTest //: SdkTest
{
	[TestMethod]
	public void TestThis()
	{
		var actual = 1;
		var expected = 1;
		Assert.AreEqual(expected, actual);
	}
}