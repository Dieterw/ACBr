using System;
using System.ComponentModel;

namespace ACBrFramework
{
	[DesignerCategory("ACBr")]
	[DesignTimeVisible(true)]
	public abstract class ACBrComponent : ACBrInteropBase, IComponent, IDisposable
	{
		#region Inner Types

		protected delegate int CreateEntryPointDelegate(ref IntPtr handle);

		protected delegate int DestroyEntryPointDelegate(ref IntPtr handle);

		#endregion Inner Types

		#region Events

		public event EventHandler Disposed;

		#endregion Events

		#region Fields

		private IntPtr handle;
		private ISite site;

		#endregion Fields

		#region Properties

		[Browsable(false)]
		public override IntPtr Handle
		{
			get
			{
				return handle;
			}
		}

		#endregion Properties

		#region Constructor

		static ACBrComponent()
		{
			UnmanagedResources.Extract();
		}

		protected ACBrComponent()
		{
			OnInitializeComponent();
		}

		~ACBrComponent()
		{
			this.Dispose(false);
		}

		#endregion Constructor

		#region P/Invoke Helpers

		protected void CallCreate(CreateEntryPointDelegate entryPoint)
		{
			var ret = entryPoint(ref this.handle);
			CheckResult(ret);
		}

		protected void CallDestroy(DestroyEntryPointDelegate entryPoint)
		{
			#region Comments (Exception on Disposing)

			//Rodando dentro do Visual Studio
			//o Debugger causa um AccessViolationException
			//ao inspecionar a chamada ao entryPoint do Destroy
			//
			//-----------------------------------------------------------------
			//Isso é resolvido abrindo as propriedades do projeto EXECUTÁVEL,
			//na aba "Debug" e marcando a opção "Enable unmanaged code debugging"
			//-----------------------------------------------------------------
			//
			//Como a maioria dos usuários não adota esse procedimento,
			//a exception é coletada no Try/Catch e não é disparada
			//caso o ambiente seja DEBUG
			//
			//Note que o erro ocorre apenas quando roda dentro do VS por causa do Debugger com código nativo
			//Tanto compilando em RELASE quanto DEBUG

			#endregion Comments (Exception on Disposing)

			try
			{
				var ret = entryPoint(ref this.handle);
				CheckResult(ret);
			}
			catch (AccessViolationException)
			{
#if !DEBUG
				throw;
#endif
			}
		}

		#endregion P/Invoke Helpers

		#region Abstract Methods

		protected internal abstract void OnInitializeComponent();

		protected abstract void OnDisposing();

		#endregion Abstract Methods

		#region Dispose Methods

		private void Dispose(bool disposing)
		{
			if (disposing)
			{
				GC.SuppressFinalize(this);
			}

			OnDisposing();

			if (Disposed != null) Disposed(this, EventArgs.Empty);
		}

		public void Dispose()
		{
			this.Dispose(true);
		}

		#endregion Dispose Methods

		#region IComponent

		ISite IComponent.Site
		{
			get
			{
				return this.site;
			}
			set
			{
				this.site = value;
			}
		}

		[Browsable(false)]
		protected virtual bool DesignMode
		{
			get
			{
				bool isDesignMode = LicenseManager.UsageMode == LicenseUsageMode.Designtime;

				if (!isDesignMode)
				{
					isDesignMode = site != null && site.DesignMode;
				}

				return isDesignMode;
			}
		}

		#endregion IComponent
	}
}