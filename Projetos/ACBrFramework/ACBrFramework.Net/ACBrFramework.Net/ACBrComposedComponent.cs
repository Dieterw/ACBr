using System;

namespace ACBrFramework
{
	public abstract class ACBrComposedComponent : ACBrInteropBase
	{
		#region Properties

		public ACBrComponent Parent { get; private set; }

		public override IntPtr Handle
		{
			get
			{
				return Parent.Handle;
			}
		}

		#endregion Properties

		#region Constructor

		protected ACBrComposedComponent(ACBrComponent parent)
		{
			this.Parent = parent;
		}

		#endregion Constructor

		#region Methods

		protected internal override void CheckResult(int result)
		{
			Parent.CheckResult(result);
		}

		#endregion Methods
	}
}