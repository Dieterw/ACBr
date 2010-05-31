using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ACBr.Net
{
    public class ACBrException : Exception
    {
        public ACBrException(string message) : base(message) { }
    }
}
