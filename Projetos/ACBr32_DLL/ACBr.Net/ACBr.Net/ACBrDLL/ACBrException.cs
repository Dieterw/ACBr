using System;

namespace ACBr.Net
{
	public class ACBrException : Exception
	{
		public ACBrException(string message) : base(message) { }
	}
}