using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;

namespace MSBuild.TestProjects.WinServiceApp
{
	static class Program
	{
		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		static void Main()
		{
			var ServicesToRun = new ServiceBase[]
			{
				new MainService()
			};
			ServiceBase.Run(ServicesToRun);
		}
	}
}