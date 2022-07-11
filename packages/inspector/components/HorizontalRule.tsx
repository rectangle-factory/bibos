export function HorizontalRule(props: { className?: string }) {
  return <div className={`w-full border-t border-t-border ${props.className}`} />;
}

HorizontalRule.defaultProps = {
  className: "",
};
